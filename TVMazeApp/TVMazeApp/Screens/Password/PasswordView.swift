//
//  PasswordView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 03/03/24.
//

import SwiftUI

struct PasswordView: View {
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
                
                SecureField("Enter password to continue", text: $accountViewModel.passwordTyped)
                    .multilineTextAlignment(.center)
                    .padding([.trailing, .leading])
                    .padding([.top, .bottom], 16)
                
                if accountViewModel.isShowingAlertText {
                    Text(accountViewModel.alertText)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.red)
                        .padding(.bottom, 16)
                }
                
                Button {
                    withAnimation(.easeInOut) {
                        accountViewModel.validatePassword()
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
            accountViewModel.validatePasswordBiometrics()
        }
        .frame(width: 300, height: 320)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 40)
    }        
}

#Preview {
    PasswordView()
}
