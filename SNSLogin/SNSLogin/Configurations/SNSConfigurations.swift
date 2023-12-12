//
//  SNSConfigurations.swift
//  SNSLogin
//
//  Created by sookim on 12/12/23.
//

import Foundation

final class SNSConfigurations {

    enum Key: String {
        case kakaoAPIkey = "kakaoAPIkey"
        case baseURL = "baseURL"
    }

    static func getValueFor(_ key: Key) -> String {
        if let dictionary = Bundle.main.object(forInfoDictionaryKey: "CustomConfigurations") as? [String: String],
           let value = dictionary[key.rawValue] {
            return value
        } else {
            fatalError("Key 값을 찾아오지 못했습니다.")
        }
    }
    
}
