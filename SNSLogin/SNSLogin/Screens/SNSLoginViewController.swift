//
//  SNSLoginViewController.swift
//  SNSLogin
//
//  Created by sookim on 12/11/23.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then
import KakaoSDKUser

class SNSLoginViewController: UIViewController {

    lazy private var buttonStackView = UIStackView(arrangedSubviews: [kakaoLoginButton]).then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    lazy private var kakaoLoginButton = PrimaryButton(backgroundColor: .systemYellow, title: "카카오 로그인")
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "로그인"
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
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }

    private func bindButton() {
        kakaoLoginButton.rx.tap.bind { [weak self] in
            guard let self
            else { return }
            
            // 카카오톡 실행 가능 여부 확인
            if (UserApi.isKakaoTalkLoginAvailable()) {
                UserApi.shared.loginWithKakaoTalk() {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    } else {
                        print("loginWithKakaoTalk() success.")
                        self.pushToSuccessViewController(successText: "카카오 간편로그인 성공")
                        
                        _ = oauthToken
                    }
                }
            } else {
                UserApi.shared.loginWithKakaoAccount() {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    } else {
                        print("loginWithKakaoAccount() success.")
                        self.pushToSuccessViewController(successText: "카카오 웹로그인 성공")
                        
                        _ = oauthToken
                    }
                }
            }
        }
        .disposed(by: disposeBag)
    }
    
    private func pushToSuccessViewController(successText: String) {
        let vc = SuccessViewController(successText: successText)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
