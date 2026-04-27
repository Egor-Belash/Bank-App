//
//  KeychainService.swift
//  Bank App
//
//  Created by Egor on 26.04.2026.
//

import UIKit
import Security

final class KeychainService {
    static let shared = KeychainService()
    
    private let keychainService = "-67jygj.Bank-App"
    
    func savePasswordToKeychain(login: String, password: String) {
        guard let data = password.data(using: .utf8) else { return }
        
        let deleteQuery: [String: Any] = [
            kSecClass as String:       kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: login
        ]
        
        SecItemDelete(deleteQuery as CFDictionary)

        let query: [String: Any] = [
            kSecClass as String:        kSecClassGenericPassword,
            kSecAttrService as String:  keychainService,
            kSecAttrAccount as String:  login,
            kSecValueData as String:    data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecSuccess {
            print("Password saved to keychain")
        } else {
            print("Error saving password to keychain: \(status)")
        }
    }
    
    func loadPasswordFromKeychain(login: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String:        kSecClassGenericPassword,
            kSecAttrService as String:  keychainService,
            kSecAttrAccount as String:  login,
            kSecReturnData as String:   true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        switch status {
            case errSecSuccess:
            if let data = result as? Data,
               let value = String(data: data, encoding: .utf8) {
                print("Password is loaded from keychain")
                return value
            }
            case errSecItemNotFound:
            print("Password not found in keychain, \(status)")
            return nil
        default:
            return nil
        }
        
        return nil
    }

}
