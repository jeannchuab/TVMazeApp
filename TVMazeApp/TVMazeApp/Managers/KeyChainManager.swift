//
//  KeyChainManager.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 03/03/24.
//

import Foundation

class KeyChainManager {
    enum KeyChainError: Error {
        case duplicatedEntry
        case unknown(OSStatus)
        
        static func save(service: String, account: String, passoword: Data) throws {
            let query: [String: AnyObject] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service as AnyObject,
                kSecAttrAccount as String: account as AnyObject,
                kSecValueData as String: passoword as AnyObject,
            ]
            
            let status = SecItemAdd(query as CFDictionary, nil)
            
            guard status != errSecDuplicateItem else {
                throw duplicatedEntry
            }
            
            guard status == errSecSuccess else {
                throw unknown(status)
            }
            
            print("Data saved on Keychain")
        }
        
        static func get() {
            
        }
    }
}
