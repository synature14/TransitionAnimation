//
//  DismissAnimator.swift
//  RxSwiftEx
//
//  Created by SutieDev on 08/11/2019.
//  Copyright © 2019 developers. All rights reserved.
//

import UIKit

class DismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let duration = 0.6
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to),
            let fromView = transitionContext.view(forKey: .from),
            let toNavi = transitionContext.viewController(forKey: .to) as? UINavigationController,
            let toController = toNavi.topViewController as? ShoppingMainController,
            let fromController = (transitionContext.viewController(forKey: .from) as? UINavigationController)?.topViewController as? ItemDetailController,
            let toCell = toController.collectionView?.cellForItem(at: toController.selectedIndexPath!) as? ItemCell else { return }
        
        
        fromView.layer.masksToBounds = true
        fromView.layer.cornerRadius = 20
        
        transitionContext.containerView.addSubview(fromView)
        transitionContext.containerView.bringSubviewToFront(fromView)
        
        toView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)

        toNavi.view.alpha = 0.0
        
        UIView.animate(withDuration: duration, animations: {
            toController.view.frame = self.originFrame
            toNavi.view.alpha = 1.0
            fromController.view.alpha = 0.0
        }) { (finished) in
            transitionContext.completeTransition(finished)
        }
    }
    
//    private func contractionViewRect(to viewController: ShoppingMainController, to cell: ItemCell) -> CGRect {
//        let origin = CGPoint(x: cell.frame.origin.x,
//                                 y: cell.frame.origin.y - viewController.collectionView!.contentOffset.y)
//        return CGRect(origin: origin, size: cell.frame.size)
//    }
}
