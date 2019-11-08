//
//  PopAnimator.swift
//  RxSwiftEx
//
//  Created by SutieDev on 06/11/2019.
//  Copyright © 2019 developers. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    enum TransitionMode {
        case present, dismiss, pop
    }
    
    let duration = 0.8
    var transitionMode: TransitionMode = .present
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to), let fromView = transitionContext.view(forKey: .from) else {
            return
        }
        
        switch transitionMode {
        case .present:
            let initialFrame = originFrame
            let finalFrame = fromView.frame
            let xScaleFactor = initialFrame.width / finalFrame.width
            let yScaleFactor = finalFrame.height / initialFrame.height
            let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
            
            fromView.transform = scaleTransform
            fromView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
            fromView.clipsToBounds = true
            fromView.layer.cornerRadius = 25.0
            
        case .dismiss:
            let initialFrame = fromView.frame
            let finalFrame = originFrame
            
            let xScaleFactor = finalFrame.width / initialFrame.width
            let yScaleFactor = initialFrame.height / finalFrame.height
            let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
            
            fromView.layer.cornerRadius = 0.0
        case .pop:
            print()
        }
        
        fromView.layer.masksToBounds = true
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(fromView)
        toView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        
        
        
        UIView.animate(withDuration: 0.5, animations: {
            fromView.transform = self.presenting ? .identity : scaleTransform
            fromView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            fromView.layer.cornerRadius = !self.presenting ? 25.0 : 0.0
            
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
        
    }
}
