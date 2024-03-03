//
//  CustomError.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import Foundation

enum CustomError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
    case unableToComplete
    case unknownError
    case invalidFavorite
    case endpointNotFound
    case missingRequiredFields
    case invalidEmail
    case userSaveSucess
    case invalidUserData
}
