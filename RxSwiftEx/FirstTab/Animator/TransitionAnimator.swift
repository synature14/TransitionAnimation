//
//  PopAnimator.swift
//  RxSwiftEx
//
//  Created by SutieDev on 06/11/2019.
//  Copyright © 2019 developers. All rights reserved.
//

import UIKit

class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.8
    var isPresenting: Bool = true
    var originFrame: CGRect = .zero
    var destinationCartCellFrame: CGRect = .zero        // CartItem보여줄 collectionView의 cell
    var lastIndexPath: IndexPath?
    
    var selectedItem: PastaModel!

    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            return animatePresentMode(using: transitionContext)
        } else {
            return animateDismissMode(using: transitionContext)
        }
    }
}

private extension TransitionAnimator {
    func animatePresentMode(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to) as? ItemDetailController else {
                return
        }
        
        // 이미지
        let imageView = UIImageView(image: selectedItem.image)
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        
        let containerView = transitionContext.containerView
        containerView.backgroundColor = .white
        containerView.addSubview(toVC.view)
        containerView.addSubview(imageView)
        imageView.frame = originFrame
        
        toVC.view.alpha = 0
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        
        UIView.animate(withDuration: 0.5, animations: {
            let toVCImageViewFrameOrigin = toVC.itemImageView.frame.origin
            imageView.frame.origin = CGPoint(x: toVCImageViewFrameOrigin.x + (toVC.itemImageView.frame.width / 4) - 5 , y: toVCImageViewFrameOrigin.y + 55)
        }) { _ in
            UIView.animate(withDuration: 0.5, animations: {
                imageView.bounds = toVC.itemImageView.bounds
            }) { _ in
                toVC.view.alpha = 1
                imageView.removeFromSuperview()
                transitionContext.completeTransition(transitionContext.transitionWasCancelled)
            }
        }
    }
    
    func animateDismissMode(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? ItemDetailController,
            let rootVC = transitionContext.viewController(forKey: .to)?.children[0] as? RootViewController,     // rootVC.firstTab가 toVC임
            let lastCell = rootVC.firstTab.cartCollectionView.dequeueReusableCell(withReuseIdentifier: "CartItemCell", for: lastIndexPath!) as? CartItemCell else {
            return
        }
        
        // 이미지
        let imageView = UIImageView(image: selectedItem.image)
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        
        let containerView = transitionContext.containerView
        containerView.addSubview(fromVC.itemImageView)
        imageView.frame = originFrame
        
        // CartCollectionView
        lastCell.cartImageView.alpha = 0
        
        UIView.animate(withDuration: 1.0, animations: {
            imageView.frame = self.destinationCartCellFrame  //////////////
        }) { _ in
            lastCell.cartImageView.alpha = 1
            imageView.removeFromSuperview()
            transitionContext.completeTransition(transitionContext.transitionWasCancelled)
        }
    }
}
