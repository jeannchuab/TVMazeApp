//
//  UserModel.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 03/03/24.
//

import Foundation

struct UserModel: Codable {
    var firstName: String = ""
    var lastName: String = ""
    var password: String = ""
    var email: String = ""
    var birthday: Date = Date()
    var extraNapkings: Bool = false
    var frequentRefills: Bool = false
}
