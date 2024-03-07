//
//  KeyChainManager.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 03/03/24.
//

import Foundation

enum KeyChainError: Error, Equatable {
    case duplicatedEntry
    case unknown(OSStatus)
    case invalidData
    case dataNotFound
}

class KeyChainManager {    
    static private let service = "TVMazeApp"
    static private let account = "default"
            
    static func save(user: Data) throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecValueData: user,
        ] as CFDictionary
        
        var status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            
            let queryUpdate = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrService: service,
                kSecAttrAccount: account,
            ] as CFDictionary
            
            let attributesToUpdate = [kSecValueData: user] as CFDictionary
            
            status = SecItemUpdate(queryUpdate, attributesToUpdate)
        }
        
        guard status == noErr else {
            throw KeyChainError.unknown(status)
        }
        
        print("Data saved on Keychain")
    }
    
    static func getUser() throws -> Data {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            kSecReturnData: true,
        ] as CFDictionary
        
        var data: AnyObject?
        
        let status = SecItemCopyMatching(query, &data)
        
        guard data != nil else {
            throw KeyChainError.dataNotFound
        }
        
        guard status == errSecSuccess else {
            throw KeyChainError.unknown(status)
        }
        
        print("Data retrieve from Keychain. Status: \(status)")
        
        guard let result = data as? Data else {
            throw KeyChainError.invalidData
        }
        
        return result
    }
}
