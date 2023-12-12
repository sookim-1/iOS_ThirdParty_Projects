//
//  SuccessViewController.swift
//  SNSLogin
//
//  Created by sookim on 12/11/23.
//

import UIKit
import SnapKit
import Then

class SuccessViewController: UIViewController {

    lazy private var successLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight: .heavy)
    }
    
    init(successText: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.successLabel.text = successText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        addSubviews()
        setupConstraints()
    }
 
    private func addSubviews() {
        self.view.addSubviews(views: successLabel)
    }
    
    private func setupConstraints() {
        successLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}
