//
//  PasswordView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 03/03/24.
//

import SwiftUI

struct PasswordView: View {
    @Binding var isShowing: Bool
    @State var isShowingWrongPassAlert: Bool = false
    @State var password: String = ""
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
                
                if isShowingWrongPassAlert {
                    Text("Wrong password. Try again.")
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
                isShowingWrongPassAlert = true
            }
        }
    }
}

#Preview {
    PasswordView(isShowing: .constant(true))
}
