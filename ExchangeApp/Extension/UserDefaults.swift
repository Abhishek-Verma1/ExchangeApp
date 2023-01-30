//
//  UserDefaultExtension.swift
//  ExchangeApp
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import Foundation

extension UserDefaults {
    func setCodableObject<T: Codable>(_ data: T?, forKey defaultName: String) {
        let encoded = try? JSONEncoder().encode(data)
        set(encoded, forKey: defaultName)
    }
    
    func codableObject<T : Codable>(dataType: T.Type, key: String) -> T? {
        guard let userDefaultData = data(forKey: key) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: userDefaultData)
    }
}
