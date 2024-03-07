//
//  UserModel.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 03/03/24.
//

import Foundation

struct UserModel: Codable, Equatable {
    var firstName: String = ""
    var lastName: String = ""
    var password: String = ""
    var email: String = ""
    var birthday: Date = Date()
    
    var isBiometricsEnabled: Bool = false {
        didSet {
            if isBiometricsEnabled {
                isPasswordRequiredLaunch = true
            }            
        }
    }
    
    var isPasswordRequiredLaunch: Bool = false
}
