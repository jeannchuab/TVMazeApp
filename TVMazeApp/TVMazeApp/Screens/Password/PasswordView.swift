//
//  PasswordView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 03/03/24.
//

import LocalAuthentication
import SwiftUI

struct PasswordView: View {
    @Binding var isShowing: Bool
    @State var isShowingAlertText: Bool = false
    @State var password: String = ""
    @State var alertText = "Wrong password. Try again."
    @EnvironmentObject var accountViewModel: AccountViewModel
    
    var body: some View {
        
        ZStack {
            BackgroundView()
            
            VStack {
                Text("Application secure")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 4)
                    .padding(.top, 32)
                
                Text("This application is restricted. To continue enter the password: ")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding([.trailing, .leading])
                    .padding(.top, 8)
                
                SecureField("Enter password to continue", text: $password)
                    .multilineTextAlignment(.center)
                    .padding([.trailing, .leading])
                    .padding([.top, .bottom], 16)
                
                if isShowingAlertText {
                    Text(alertText)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.red)
                        .padding(.bottom, 16)
                }
                
                Button {
                    withAnimation(.easeInOut) {
                        validatePassword()
                    }
                } label: {
                    Text("OK")
                        .bold()
                        .frame(width: 140, height: 40)
                        .foregroundStyle(.white)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
            }
        }
        .onAppear {
            validatePasswordBiometrics()
        }
        .frame(width: 300, height: 320)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 40)
    }
    
    func validatePassword() {
        if accountViewModel.userModel.password == password {
            isShowing = false
        } else {
            withAnimation(.easeInOut) {
                isShowingAlertText = true
            }
        }
    }
    
    func validatePasswordBiometrics() {
        
        guard accountViewModel.userModel.isBiometricsEnabled else { return }
        
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Face ID is used to securely authenticate your identity within the app, ensuring your privacy and security."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    isShowing = false
                } else {
                    print("Biometrics not authenticated.")
                }
            }
        } else {
            print("Biometrics is not available")
        }
    }
}

#Preview {
    PasswordView(isShowing: .constant(true))
}
