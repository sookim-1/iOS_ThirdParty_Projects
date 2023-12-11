//
//  PrimaryButton.swift
//  SNSLogin
//
//  Created by sookim on 12/11/23.
//

import UIKit
import SnapKit
import Then

class PrimaryButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, title
         : String) {
        self.init(frame: .zero)
        
        set(backgroundColor: backgroundColor, title: title)
    }
    
    private func configure() {
        self.layer.cornerRadius = 10
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    private func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
}
