//
//  UIImageView+Ext.swift
//  LoodosMovie
//
//  Created by Hamza Eren Koc on 4.06.2024.
//

import UIKit

extension UIImageView {
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.backgroundColor = .black
        blurEffectView.alpha = 0.95
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}
