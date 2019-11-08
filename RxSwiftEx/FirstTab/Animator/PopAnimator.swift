//
//  PopAnimator.swift
//  RxSwiftEx
//
//  Created by SutieDev on 06/11/2019.
//  Copyright © 2019 developers. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.8
    var isPresenting: Bool = true
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to),
            let fromView = isPresenting ? toView : transitionContext.view(forKey: .from) else {
            return
        }
        
        let initialFrame = isPresenting ? originFrame : fromView.frame
        let finalFrame = isPresenting ? fromView.frame : originFrame
        
        let xScaleFactor = isPresenting ?
          initialFrame.width / finalFrame.width :
          finalFrame.width / initialFrame.width
        
        let yScaleFactor = isPresenting ?
          initialFrame.height / finalFrame.height :
          finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if isPresenting {
          fromView.transform = scaleTransform
          fromView.center = CGPoint(
            x: initialFrame.midX,
            y: initialFrame.midY)
          fromView.clipsToBounds = true
        }
        
        fromView.layer.cornerRadius = isPresenting ? 25.0 : 0.0
        fromView.layer.masksToBounds = true
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(fromView)
        toView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        
        UIView.animate(withDuration: 0.5, animations: {
            fromView.transform = self.isPresenting ? .identity : scaleTransform
            fromView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            fromView.layer.cornerRadius = !self.isPresenting ? 25.0 : 0.0
            
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
        
    }
}
