//
//  UIkitExtenstion.swift
//  Project-ClonePassOrder
//
//  Created by 정덕호 on 2022/05/13.
//

import UIKit

extension UIView {
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        layer.masksToBounds = false
    }
    func getLabelHeight(_ yourLabel : UILabel) -> CGFloat {
        var height = ("1" as! NSString).size(withAttributes: [NSAttributedString.Key.font : yourLabel.font]).height
        return height
    }
}
