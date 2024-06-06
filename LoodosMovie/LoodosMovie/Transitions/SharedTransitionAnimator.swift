//
//  SharedTransitionAnimator.swift
//  LoodosMovie
//
//  Created by Hamza Eren Koc on 5.06.2024.
//

import UIKit


class SharedTransitionAnimator: NSObject {
    enum Transition {
        case push
        case pop
    }
    var transition: Transition = .push
}

protocol SharedTransitioning {
    var sharedFrame: CGRect { get }
}


extension SharedTransitionAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?
    ) -> TimeInterval { 0.2 }
    
    
    private func setup(
        with context: UIViewControllerContextTransitioning
    ) -> (UIView, CGRect, UIView, CGRect)? {
        
        guard let toView = context.view(forKey: .to),
              let fromView = context.view(forKey: .from) else {
            return nil
        }
        
        if transition == .push {
            context.containerView.addSubview(toView)
        } else {
            context.containerView.insertSubview(toView, belowSubview: fromView)
        }
        
        guard let toFrame = context.sharedFrame(forKey: .to),
              let fromFrame = context.sharedFrame(forKey: .from) else {
            return nil
        }
        
        return (fromView, fromFrame, toView, toFrame)
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch transition {
        case .push:
            pushAnimation(context: transitionContext)
        case .pop:
            popAnimation(context: transitionContext)
        }
    }
    
    
    private func pushAnimation(context: UIViewControllerContextTransitioning) {
      
        guard let (fromView, fromFrame, toView, toFrame) = setup(with: context) else {
            context.completeTransition(false)
            return
        }
     
        
        let transform: CGAffineTransform = .transform(
            parent: toView.frame,
            soChild: toFrame,
            aspectFills: fromFrame
        )
        toView.transform = transform
        
        
        let maskFrame = toFrame
        let mask: UIView = {
            let mask = UIView(frame: maskFrame)
            mask.layer.cornerCurve = .continuous
            mask.backgroundColor = .black
            return mask
        }()
        toView.mask = mask
        
        
        let placeholder: UIView = {
            let placeholder = UIView()
            placeholder.backgroundColor = .white
            placeholder.frame = fromFrame
            return placeholder
        }()
        fromView.addSubview(placeholder)
        
        
        let overlay: UIView = {
            let overlay = UIView()
            overlay.backgroundColor = .black
            overlay.layer.opacity = 0
            overlay.frame = fromView.frame
            return overlay
        }()
        fromView.addSubview(overlay)
        
        
        UIView.animate(withDuration: 0.25) {
            toView.transform = .identity
            mask.frame = toView.frame
            mask.layer.cornerRadius = 39
            overlay.layer.opacity = 0.5
        } completion: { _ in
            toView.mask = nil
            overlay.removeFromSuperview()
            placeholder.removeFromSuperview()
            context.completeTransition(true)
        }
    }
    
    
    private func popAnimation(context: UIViewControllerContextTransitioning) {
      
        guard let (fromView, fromFrame, toView, toFrame) = setup(with: context) else {
            context.completeTransition(false)
            return
        }
        
       
        let transform: CGAffineTransform = .transform(
            parent: fromView.frame,
            soChild: fromFrame,
            aspectFills: toFrame
        )
  
        
        let mask: UIView = {
            let mask = UIView(frame: fromView.frame)
            mask.layer.cornerCurve = .continuous
            mask.backgroundColor = .black
            mask.layer.cornerRadius = 39
            return mask
        }()
        fromView.mask = mask
        
     
        let placeholder: UIView = {
            let placeholder = UIView()
            placeholder.backgroundColor = .white
            placeholder.frame = toFrame
            return placeholder
        }()
        toView.addSubview(placeholder)
        
        
        let overlay: UIView = {
            let overlay = UIView()
            overlay.backgroundColor = .black
            overlay.layer.opacity = 0.5
            overlay.frame = toView.frame
            return overlay
        }()
        toView.addSubview(overlay)
        
        
        let maskFrame = fromFrame
        UIView.animate(withDuration: 0.25) {
            fromView.transform = transform
            mask.frame = maskFrame
            mask.layer.cornerRadius = 0
            overlay.layer.opacity = 0
        } completion: { _ in
            overlay.removeFromSuperview()
            placeholder.removeFromSuperview()
            let isCancelled = context.transitionWasCancelled
            context.completeTransition(!isCancelled)
        }
    }
}
