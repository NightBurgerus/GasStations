//
//  AuthView.swift
//  AZS
//
//  Created by Паша Терехов on 03.01.2023.
//

import SwiftUI

// TODO:
// - обработка ответа сервера
// - продумать ответ сервера
// - запрос на получение пользовательских данных
struct AuthView: View {
    @EnvironmentObject private var controllers: Controllers
    @EnvironmentObject private var profile: Profile
    @Environment(\.colorScheme) private var colorScheme
    @State private var foregroundColor = Res.colors.black
    @State private var backgroundColor = Res.colors.white
    @StateObject private var authVM = AuthViewModel()
    @StateObject private var profileVM = ProfileViewModel()
    @State private var username = ""
    @State private var password = ""
    @State private var labelAnimation = false
    
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var action: Int? = nil
    
    var body: some View {
        ZStack {
            VStack {
                Label()
                LoginTextField()
                PasswordTextField()
                
                Spacer()
                
                CustomButton(label: Res.strings.auth.loginButton) {
                    authButtonTapped()
                }.disabled(authVM.dataIsLoading)
                
                RegularText(Res.strings.register.registerButton, fontSize: .s16)
                    .padding(.vertical, 30)
                    .padding(.bottom, controllers.tabBarController?.tabBar.frame.height ?? 100.0)
                    .foregroundColor(Res.colors.blue)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        action = 1
                    }
                    .disabled(authVM.dataIsLoading)
                
            }
            
            if showToast {
                VStack {
                    Spacer()
                    Toast(isShowing: $showToast, text: toastMessage)
                }.padding(.bottom, controllers.tabBarController?.tabBar.frame.height ?? 100.0)
            }
            
            if authVM.dataIsLoading || profileVM.dataIsLoading {
                LoadingScreen()
            }
            
            NavigationLink(destination: RegisterView().navigationBarBackButtonHidden(true), tag: 1, selection: $action) {}
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
        action = nil
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
    
    private func authButtonTapped() {
        if username.isEmpty || password.isEmpty {
            toastMessage = Res.strings.toast.emptyFields
            withAnimation {
                showToast = true
            }
            return
        }
        
        authVM.login(username: username, password: password) { response in
            authHandler(response: response)
        }
    }
    
    private func authHandler(response: ResponseResult<(any ResponseProtocol)?, LoadingError?>) {
        print("~ ", response)
        switch response {
        case .success(let data):
            guard let info = (data as? AuthResponse)?.data, data!.response else {
                toastMessage = Res.strings.errors.authError
                withAnimation {
                    showToast = true
                }
                return
            }
            
            // Получение пользовательских данных по аксес токену
            profileVM.getPersonalData(withToken: info.accessToken) { response in
                switch response {
                case .success(let data):
                    guard let profileInfo = (data as? ProfileResponse)?.data, data!.response else {
                        toastMessage = Res.strings.errors.authError
                        withAnimation {
                            showToast = true
                        }
                        return
                    }
                    profile.username    = username
                    profile.firstName   = profileInfo.firstName
                    profile.lastName    = profileInfo.lastName
                    profile.accessToken = info.accessToken
                    UserDefaults.standard.setData(from: profile)
                    
                case .failture(let error):
                    switch error {
                    case .Error: break
                    case .DataIsNil: break
                    case .DecodingError: break
                    case .InvalidURL: break
                    case .InvalidStatusCode: break
                    default: break
                    }
                }
            }
        case .failture(_):
            toastMessage = Res.strings.errors.authError
            withAnimation {
                showToast = true
            }
        }
    }
    
    private func Label() -> some View {
        HStack {
            BoldText(Res.strings.auth.label, fontSize: .s24)
                .opacity(labelAnimation ? 1.0 : 0.0)
                .offset(y: labelAnimation ? 0 : 20)
                .foregroundColor(foregroundColor)
            Spacer()
        }.padding(20)
    }
    
    private func LoginTextField() -> some View {
        VStack(spacing: 10) {
            HStack {
                BoldText(Res.strings.auth.login, fontSize: .s16)
                Spacer()
            }
            UserTextField(title: Res.strings.auth.login, text: $username, textFieldType: .login)
        }.padding([.top, .horizontal], 20)
    }
    
    private func PasswordTextField() -> some View {
        VStack(spacing: 10) {
            HStack {
                BoldText(Res.strings.auth.password, fontSize: .s16)
                Spacer()
            }
            UserTextField(title: Res.strings.auth.password, text: $password, textFieldType: .password)
        }.padding([.top, .horizontal], 20)
    }
}
