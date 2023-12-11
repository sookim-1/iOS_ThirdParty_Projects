//
//  ViewController.swift
//  SNSLogin
//
//  Created by sookim on 12/11/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class ViewController: UIViewController {

    lazy private var buttonStackView = UIStackView(arrangedSubviews: [signUpButton, loginButton]).then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    lazy private var signUpButton = PrimaryButton(backgroundColor: .systemBlue, title: "회원가입")
    lazy private var loginButton = PrimaryButton(backgroundColor: .systemPink, title: "로그인")
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        addSubviews()
        setupConstraints()
        bindButton()
    }
    
    private func addSubviews() {
        self.view.addSubviews(views: buttonStackView)
    }
    
    private func setupConstraints() {
        buttonStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(150)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }

    private func bindButton() {
        signUpButton.rx.tap.bind { [weak self] in
            guard let self
            else { return }
            
            self.pushToSignUpViewController()
        }
        .disposed(by: disposeBag)
        
        loginButton.rx.tap.bind { [weak self] in
            guard let self
            else { return }
            
            self.pushToLoginViewController()
        }
        .disposed(by: disposeBag)
    }

    private func pushToSignUpViewController() {
        let vc = SNSSignUpViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func pushToLoginViewController() {
        let vc = SNSLoginViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

