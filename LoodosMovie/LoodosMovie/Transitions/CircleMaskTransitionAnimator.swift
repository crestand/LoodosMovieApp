//
//  CircleMaskTransitionAnimator.swift
//  LoodosMovie
//
//  Created by Hamza Eren Koc on 6.06.2024.
//

import UIKit

class CircleMaskTransitionAnimator: NSObject {
    enum Transition {
        case push
        case pop
    }
    var transition: Transition = .push
}


protocol CircleMaskTransitioning {
    var sharedFrame: CGRect { get }
}


extension CircleMaskTransitionAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.75
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch transition {
        case .push:
            pushAnimation(context: transitionContext)
        case .pop:
            popAnimation(context: transitionContext)
        }
    }
    
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
    
    private func pushAnimation(context: UIViewControllerContextTransitioning) {
        
        guard let toView = context.view(forKey: .to) else { 
            context.completeTransition(false)
            return }
      
        let containerView = context.containerView
        
        let mask: UIView = {
            let mask = UIView(frame: CGRect(x: 0, y: 0, width: 2, height: 2))
            mask.center = containerView.center
            mask.layer.cornerRadius = 1
            mask.backgroundColor = .white
            return mask
        }()
        toView.mask = mask
        
        let bounds = containerView.bounds
        containerView.addSubview(toView)
        toView.frame = bounds
        
        
        let toWidth = bounds.height * 1.3
        
        UIView.animate(withDuration: 1.25) {
            mask.frame = CGRect(x: 0, y: 0, width: toWidth, height: toWidth)
            mask.layer.cornerRadius = toWidth/2
            mask.center = containerView.center
        } completion: { _ in
            toView.mask = nil
            context.completeTransition(true)
        }
    }
    
    
    private func popAnimation(context: UIViewControllerContextTransitioning) {
        //Not needed for now
    }
}
