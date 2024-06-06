//
//  UIViewControllerContextTransitioning+Ext.swift
//  LoodosMovie
//
//  Created by Hamza Eren Koc on 6.06.2024.
//

import UIKit

extension UIViewControllerContextTransitioning {
    func sharedFrame(forKey key: UITransitionContextViewControllerKey) -> CGRect? {
        let viewController = viewController(forKey: key)
        viewController?.view.layoutIfNeeded()
        return (viewController as? SharedTransitioning)?.sharedFrame
    }
}
