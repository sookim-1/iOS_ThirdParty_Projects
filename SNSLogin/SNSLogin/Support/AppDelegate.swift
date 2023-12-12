//
//  AppDelegate.swift
//  SNSLogin
//
//  Created by sookim on 12/11/23.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import NaverThirdPartyLogin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        KakaoSDK.initSDK(appKey: SNSConfigurations.getValueFor(.kakaoAPIkey))
        settingNaverSNSLogin()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    func settingNaverSNSLogin() {
        // 네이버 앱 간편로그인 활성화
        NaverThirdPartyLoginConnection.getSharedInstance()?.isNaverAppOauthEnable = true
        
        // 네이버 웹 로그인 활성화
        NaverThirdPartyLoginConnection.getSharedInstance()?.isInAppOauthEnable = true
        
        // 네이버 로그인 세로모드 고정
        NaverThirdPartyLoginConnection.getSharedInstance().setOnlyPortraitSupportInIphone(true)
        
        // NaverThirdPartyConstantsForApp.h에 선언한 상수 등록
        NaverThirdPartyLoginConnection.getSharedInstance().serviceUrlScheme = SNSConfigurations.getValueFor(.naverAppURLScheme)
        NaverThirdPartyLoginConnection.getSharedInstance().consumerKey = SNSConfigurations.getValueFor(.naverConsumerKey)
        NaverThirdPartyLoginConnection.getSharedInstance().consumerSecret = SNSConfigurations.getValueFor(.naverConsumerSecret)
        NaverThirdPartyLoginConnection.getSharedInstance().appName = SNSConfigurations.getValueFor(.naverAppName)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
        
        return true
    }
        
    
}

