//
//  RegisterView.swift
//  AZS
//
//  Created by Паша Терехов on 04.01.2023.
//

import SwiftUI

// TODO:
// 2. Сделать обработку полей регистрации
struct RegisterView: View {
    @EnvironmentObject private var controllers: Controllers
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.presentationMode) private var presentationMode
    @State private var foregroundColor = Res.colors.black
    @State private var backgroundColor = Res.colors.white
    @StateObject private var authVM = AuthViewModel()
    
    
    // То, что вводит пользователь
    @State private var username = ""
    @State private var usernameError = false
    @State private var password = ""
    @State private var passwordError = false
    @State private var repeatPassword = ""
    @State private var repeatError  = false
    @State private var email = ""
    @State private var emailError = false
    @State private var firstName = ""
    @State private var firstNameError = false
    @State private var lastName = ""
    @State private var lastNameError = false
    
    @State private var labelAnimation = false
    
    @State private var showToast = false
    @State private var toastMessage = ""
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    Label()
                    
                    RegisterTextField(withLabel: Res.strings.register.login, input: $username, type: .login, error: $usernameError)
                    RegisterTextField(withLabel: Res.strings.register.email, input: $email, type: .email, error: $emailError)
                    RegisterTextField(withLabel: Res.strings.register.password, input: $password, type: .password, error: $passwordError)
                    RegisterTextField(withLabel: Res.strings.register.repeatPassword, input: $repeatPassword, type: .password, error: $repeatError)
                    RegisterTextField(withLabel: Res.strings.register.firstName, input: $firstName, type: .name, error: $firstNameError)
                    RegisterTextField(withLabel: Res.strings.register.lastName, input: $lastName, type: .name, error: $lastNameError)
                    
                    Spacer().frame(height: 100)
                    
                    CustomButton(label: Res.strings.register.registerButton) {
                        registerButtonTapped()
                    }.disabled(authVM.dataIsLoading)
                    
                    RegularText(Res.strings.auth.loginButton, fontSize: .s16)
                        .padding(.vertical, 30)
                        .padding(.bottom, controllers.tabBarController?.tabBar.frame.height ?? 100.0)
                        .foregroundColor(Res.colors.blue)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                        .disabled(authVM.dataIsLoading)
                    
                }
            }
            
            if showToast {
                VStack {
                    Spacer()
                    Toast(isShowing: $showToast, text: toastMessage)
                }.padding(.bottom, controllers.tabBarController?.tabBar.frame.height ?? 100.0)
            }
            
            if authVM.dataIsLoading {
                LoadingScreen()
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .contentShape(Rectangle())
        .onTapGesture {
            UIApplication.resignFirstResponder()
        }
        .onAppear {
            configureView()
        }
    }
    
    private func configureView() {
        if colorScheme == .dark {
            foregroundColor = Res.colors.white
            backgroundColor = Res.colors.black
        } else {
            foregroundColor = Res.colors.black
            backgroundColor = Res.colors.white
        }
        labelAnimation = false
        withAnimation(.easeInOut(duration: controllers.animationDuration)) {
            labelAnimation = true
        }
    }
    
    private func registerButtonTapped() {
        if username.isEmpty || email.isEmpty || password.isEmpty || repeatPassword.isEmpty || firstName.isEmpty || lastName.isEmpty {
            toastMessage  = Res.strings.toast.emptyFields
            withAnimation {
                usernameError = username.isEmpty
                emailError = email.isEmpty
                passwordError = password.isEmpty
                repeatError = repeatPassword.isEmpty
                firstNameError = firstName.isEmpty
                lastNameError = lastName.isEmpty
                showToast = true
            }
            return
        }
        let emailPattern = "([a-z0-9!#$%&'*+-/=?^_`{|}~]){1,64}@([a-z0-9!#$%&'*+-/=?^_`{|}~]){1,64}\\.([a-z0-9]){2,64}"
        // Проверка почты
        if !String.regex(emailPattern, in: email) {
            toastMessage = Res.strings.toast.incorrectEmail
            withAnimation {
                showToast = true
                emailError = true
            }
            return
        }
        
        // Длина пароля
        if password.count < 6 {
            toastMessage = Res.strings.toast.passwordLength
            withAnimation {
                showToast = true
            }
            return
            
        }
        // Пароли не совпадают
        if password != repeatPassword {
            toastMessage = Res.strings.toast.passwordsDontMatch
            withAnimation {
                showToast = true
                passwordError = true
                repeatError = true
            }
            return
        }
        
        authVM.register(username: username, password: password, firstName: firstName, lastName: lastName, completionHandler: { response in
            self.registerHandler(response: response)
        })
        
    }
    
    private func registerHandler(response: ResponseResult<(any ResponseProtocol)?, LoadingError?>) {
        switch response {
        case .success(let data): break
        case .failture(let error): break
        }
    }
    
    private func Label() -> some View {
        HStack {
            BoldText(Res.strings.register.label, fontSize: .s24)
                .opacity(labelAnimation ? 1.0 : 0.0)
                .offset(y: labelAnimation ? 0 : 20)
                .foregroundColor(foregroundColor)
            Spacer()
        }.padding(20)
    }
    
    private func RegisterTextField(withLabel label: String, input: Binding<String>, type: UserTextField.TextFieldType, error: Binding<Bool>) -> some View {
        VStack(spacing: 10) {
            HStack {
                BoldText(label, fontSize: .s16)
                Spacer()
            }
            UserTextField(title: label, text: input, textFieldType: type, error: error)
        }.padding([.top, .horizontal], 20)
    }
}
