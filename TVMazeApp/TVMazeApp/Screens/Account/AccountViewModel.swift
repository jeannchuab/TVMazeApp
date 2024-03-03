//
//  AccountViewModel.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 03/03/24.
//

import SwiftUI

final class AccountViewModel: ObservableObject {    
    @AppStorage("user") private var userData: Data?
    
    @Published var userModel = UserModel()
    @Published var alertItem: AlertItem?
    
    var isValidForm: Bool {
        guard !userModel.firstName.isEmpty,
              !userModel.lastName.isEmpty, !userModel.email.isEmpty
        else {
            alertItem = AlertItem(error: .missingRequiredFields)
            return false
        }
        
        guard userModel.email.isValidEmail else {
            alertItem = AlertItem(error: .invalidEmail)
            return false
        }
        
        return true
    }
    
    func saveChanges() {
        guard isValidForm else { return }
        
        do {
            let data = try JSONEncoder().encode(userModel)
            userData = data
            alertItem = AlertItem(error: .userSaveSucess)
        } catch {
            alertItem = AlertItem(error: .invalidUserData)
        }
    }
    
    func retrieveUser() {
        guard let userData else { return }
        
        do {
            userModel = try JSONDecoder().decode(UserModel.self, from: userData)
        } catch {
            alertItem = AlertItem(error: .invalidUserData)
        }
    }
}
