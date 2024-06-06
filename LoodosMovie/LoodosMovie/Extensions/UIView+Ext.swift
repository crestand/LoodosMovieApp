//
//  UIView+Ext.swift
//  LoodosMovie
//
//  Created by Hamza Eren Koc on 6.06.2024.
//

import UIKit

extension UIView {
    var frameInWindow: CGRect? {
        superview?.convert(frame, to: nil)
    }
}
