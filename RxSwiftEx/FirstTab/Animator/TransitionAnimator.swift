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
    var originFrmae: CGRect = .zero
    var image: UIImage?
    
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
        
        let imageView = UIImageView(image: image)
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        let containerView = transitionContext.containerView
        containerView.backgroundColor = .white
        containerView.addSubview(toVC.view)
        containerView.addSubview(imageView)
        imageView.frame = originFrmae
        toVC.view.alpha = 0
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        
        UIView.animate(withDuration: 0.5, animations: {
            imageView.frame = toVC.itemImageView.frame
        }) { _ in
            toVC.view.alpha = 1
            imageView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
    
    func animateDismissMode(using transitionContext: UIViewControllerContextTransitioning) {
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
}
