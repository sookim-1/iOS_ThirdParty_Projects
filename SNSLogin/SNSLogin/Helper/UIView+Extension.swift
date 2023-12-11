//
//  UIView+Extension.swift
//  SNSLogin
//
//  Created by sookim on 12/11/23.
//

import UIKit

extension UIView {
    
    func addSubviews(views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
    
}
