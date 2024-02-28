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
    let dismissButton: Alert.Button
}

struct AlertContext {
    
    //MARK: Network Alerts
    
    static let invalidUrl = AlertItem(title: Text("Server error"),
                                       message: Text("There was a issue connecting to the server. Please try again later or contact support."),
                                       dismissButton: .default(Text("OK")))
    
    static let invalidResponse = AlertItem(title: Text("Server error"),
                                       message: Text("Invalid response from server. Please try again later or contact support."),
                                       dismissButton: .default(Text("OK")))
    
    static let invalidData = AlertItem(title: Text("Server error"),
                                       message: Text("The data received from the server was invalid. Please try again later or contact support."),
                                       dismissButton: .default(Text("OK")))
    
    static let unableToComplete = AlertItem(title: Text("Server error"),
                                       message: Text("Unable to complete you request at this time. Please check your internet connection."),
                                       dismissButton: .default(Text("OK")))
}
