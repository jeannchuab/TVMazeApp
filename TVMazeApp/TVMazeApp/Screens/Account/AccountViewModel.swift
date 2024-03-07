//
//  AccountViewModel.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 03/03/24.
//

import LocalAuthentication
import SwiftUI

//@MainActor
final class AccountViewModel: ObservableObject {
    @Published var userModel = UserModel()
    @Published var alertItem: AlertItem?
    
    @Published var isShowingAlertText: Bool = false
    @Published var passwordTyped: String = ""
    @Published var isShowingPasswordView: Bool = false
    
    var alertText = "Wrong password. Try again."
    
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
            try KeyChainManager.save(user: data)
            
            alertItem = AlertItem(error: .userSaveSucess)
        } catch {
            alertItem = AlertItem(error: .invalidUserData)
        }
    }
    
    func retrieveUser() {
        do {
            let userData = try KeyChainManager.getUser()
            self.userModel = try JSONDecoder().decode(UserModel.self, from: userData)
            self.isShowingPasswordView = userModel.isPasswordRequiredLaunch
            
        } catch let error {
            guard let keyChainError = error as? KeyChainError else {
                alertItem = AlertItem(error: .invalidUserData)
                return
            }
            
            if keyChainError != .dataNotFound {
                alertItem = AlertItem(error: .invalidUserData)
            }
        }
    }    
    
    func validatePassword() {
        if userModel.password == passwordTyped {
            isShowingPasswordView = false
        } else {
            withAnimation(.easeInOut) {
                isShowingAlertText = true
            }
        }
    }
    
    func validatePasswordBiometrics() {
        guard userModel.isBiometricsEnabled else { return }
        
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Face ID is used to securely authenticate your identity within the app, ensuring your privacy and security."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    self.isShowingPasswordView = false
                } else {
                    print("Biometrics not authenticated.")
                }
            }
        } else {
            print("Biometrics is not available")
        }
    }
}

