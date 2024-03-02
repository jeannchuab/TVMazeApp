//
//  AlertContext.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button = .default(Text("OK"))
    
    init(error: CustomError) {
        
        switch error {
        case .invalidUrl:
            title = Text("Invalid URL")
            message = Text("There was a issue connecting to the server. Please try again in a few moments.")
            
        case .invalidResponse:
            title = Text("Server error")
            message = Text("Invalid response from server. Please try again in a few moments.")
            
        case .invalidData:
            title = Text("Server error")
            message = Text("The data received from the server was invalid. Please try again in a few moments.")
            
        case .unableToComplete:
            title = Text("Server error")
            message = Text("Unable to complete you request at this time. Please check your internet connection.")
            
        case .unknownError:
            title = Text("Unknown error")
            message = Text("An unknown occurred. Please try again in a few moments.")
            
        case .invalidFavorite:
            title = Text("Server error")
            message = Text("There was an error saving or retrieving the favorite data.")
            
        case .endpointNotFound:
            title = Text("Local error")
            message = Text("The specified endpoint was not found.")
        }
    }
}
