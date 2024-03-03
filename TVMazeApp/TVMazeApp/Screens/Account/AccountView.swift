//
//  AccountView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 03/03/24.
//

import SwiftUI

struct AccountView: View {
    @StateObject var viewModel = AccountViewModel()
        
    enum FormTextField {
        case firstName, lastName, email
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                
                Form {
                    SectionPersonalInfo(viewModel: viewModel)

                    Section("Settings") {
                        Toggle("Enable Biometrics", isOn: $viewModel.userModel.extraNapkings)
                            .tint(.accentColor)
                            
                        Toggle("Required password on launch", isOn: $viewModel.userModel.frequentRefills)
                            .tint(.accentColor)
                    }
                    
                    Button(action: {
                        viewModel.saveChanges()
                    }, label: {
                        Text("Save changes")
                    })
                }
                .scrollContentBackground(.hidden)
                .background {
                    BackgroundView()
                }
            }
            .navigationTitle("⚙️ Account")                        
        }
        .onAppear {
            viewModel.retrieveUser()
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
}

struct SectionPersonalInfo: View {
    @FocusState private var focusedTextField: FormTextField?
    @ObservedObject var viewModel: AccountViewModel
    
    enum FormTextField: Hashable {
        case firstName, lastName, password, email
    }
    
    var body: some View {
        Section("Personal Info") {
            TextField("First name", text: $viewModel.userModel.firstName)
                .autocorrectionDisabled(false)
                .focused($focusedTextField, equals: FormTextField.firstName)
                .submitLabel(.next)
                .onSubmit {
                    focusedTextField = FormTextField.lastName
                }
                
            TextField("Last name", text: $viewModel.userModel.lastName)
                .autocorrectionDisabled(false)
                .focused($focusedTextField, equals: FormTextField.lastName)
                .submitLabel(.next)
                .onSubmit {
                    focusedTextField = .password
                }
            
            SecureField("Password", text: $viewModel.userModel.password)
                .autocorrectionDisabled(false)
                .focused($focusedTextField, equals: FormTextField.password)
                .submitLabel(.next)
                .onSubmit {
                    focusedTextField = .email
                }
            
            TextField("Email", text: $viewModel.userModel.email)
                .autocorrectionDisabled(false)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .focused($focusedTextField, equals: FormTextField.email)
                .submitLabel(.continue)
                .onSubmit {
                    focusedTextField = nil //Dismiss keyboard
                }

            DatePicker("Birthday",
                       selection: $viewModel.userModel.birthday,
                       in: Date().oneHundredTwentyYearsAgo...Date(),
                       displayedComponents: .date)
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) { //Adding a toolbar to the keyboard
                HStack {
                    Spacer()
                    Button("Dismiss") {
                        focusedTextField = nil
                    }
                }
            }
        }
    }
}



#Preview {
    AccountView()
}
