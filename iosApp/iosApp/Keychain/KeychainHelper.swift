//
//  KeychainHelper.swift
//  iosApp
//
//  Created by Наталья Кизирова on 11.07.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation

final class KeychainHelper {
    static let shared = KeychainHelper()
    
    private init(){}
    
    func save(_ data: Data, service: String, account: String){
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as [CFString : Any] as CFDictionary
        
        var status = SecItemAdd(query, nil)
        
        if status == errSecDuplicateItem || status == -25299 {
            let query = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrService: service,
                kSecAttrAccount: account
            ] as [CFString : Any] as CFDictionary
            
            let attributesToUpdate = [kSecValueData: data] as CFDictionary
            
            status = SecItemUpdate(query, attributesToUpdate)
        }
        
        if status != errSecSuccess || status != 0 {
            print("Error: \(status)")
        }
    }
    
    func read(service: String, account: String) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: true
        ] as [CFString : Any] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
}
