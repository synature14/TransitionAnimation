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
        imageView.frame = originFrmae
        
        // title
        let titleLabel = UILabel()
        titleLabel.backgroundColor = .clear
        titleLabel.numberOfLines = 0
        titleLabel.text = selectedItem.title
        containerView.addSubview(titleLabel)
        titleLabel.alpha = 0
        titleLabel.frame = 
        
        
        toVC.view.alpha = 0
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        
        
        
        
        
        UIView.animate(withDuration: 0.5, animations: {
            let toVCImageViewFrameOrigin = toVC.itemImageView.frame.origin
            imageView.frame.origin = CGPoint(x: toVCImageViewFrameOrigin.x + (toVC.itemImageView.frame.width / 4), y: toVCImageViewFrameOrigin.x + 50)
        }) { _ in
            UIView.animate(withDuration: 0.25, animations: {
                
            }) { _ in
                toVC.view.alpha = 1
                imageView.removeFromSuperview()
                transitionContext.completeTransition(transitionContext.transitionWasCancelled)
            }
        }
    }
    
    func animateDismissMode(using transitionContext: UIViewControllerContextTransitioning) {
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
}
