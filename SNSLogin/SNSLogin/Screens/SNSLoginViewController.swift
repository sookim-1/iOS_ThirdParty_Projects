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
import NaverThirdPartyLogin

class SNSLoginViewController: UIViewController {

    lazy private var buttonStackView = UIStackView(arrangedSubviews: [kakaoLoginButton, naverLoginButton]).then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    lazy private var kakaoLoginButton = PrimaryButton(backgroundColor: .systemYellow, title: "카카오 로그인")
    lazy private var naverLoginButton = PrimaryButton(backgroundColor: .systemGreen, title: "네이버 로그인")
    private let disposeBag = DisposeBag()
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
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
        
        naverLoginButton.rx.tap.bind { [weak self] in
            guard let self
            else { return }
            
            loginInstance?.delegate = self
            loginInstance?.requestThirdPartyLogin()
        }
        .disposed(by: disposeBag)
    }
    
    private func pushToSuccessViewController(successText: String) {
        let vc = SuccessViewController(successText: successText)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SNSLoginViewController: NaverThirdPartyLoginConnectionDelegate {
    
    // 로그인 버튼을 눌렀을 경우 열게 될 브라우저
    func oauth20ConnectionDidOpenInAppBrowser(forOAuth request: URLRequest!) {
        print("open")
    }
    
    // 로그인에 성공했을 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("[Success] : Success Naver Login")
        
        self.pushToSuccessViewController(successText: "네이버로그인 성공")
    }
    
    // 접근 토큰 갱신
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print("token refresh")
    }
    
    // 로그아웃 할 경우 호출(토큰 삭제)
    func oauth20ConnectionDidFinishDeleteToken() {
        loginInstance?.requestDeleteToken()
    }
    
    // 모든 Error
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("[Error] :", error.localizedDescription)
    }
    
}
