//
//  CustomTextField.swift
//  AZS
//
//  Created by Паша Терехов on 03.01.2023.
//

import SwiftUI

struct UserTextField: View {
    var title: String
    @Binding var text: String
    var textFieldType: TextFieldType
    @Binding var error: Bool
    
    private var keyboardType: UIKeyboardType {
        switch textFieldType {
        case .name:
            return .default
        case .login, .password:
            return .asciiCapable
        case .email:
            return .emailAddress
        }
    }
//    @State private var error = false
    @State private var textChanged = false
    @State private var secureField = true
    @State private var showPassword = false
    
    init(title: String, text: Binding<String>, textFieldType: TextFieldType, error: Binding<Bool> = .constant(false)) {
        self.title = title
        self._text = text
        self.textFieldType = textFieldType
        self._error = error
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).stroke(error ? Color.red : textChanged ? Res.colors.blue : Res.colors.lightGray, lineWidth: 3)
            Group {
                if secureField && !showPassword {
                    ZStack {
                        HStack {
                            SecureField(title, text: $text)
                            Spacer()
                        }.padding(.trailing, 20)
                        HStack {
                            Spacer()
                            Image(systemName: showPassword ? "eye" : "eye.slash")
                                .resizable()
                                .scaledToFit()
                                .opacity(0.8)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    showPassword.toggle()
                                }
                                .frame(width: 25, height: 25)
                        }
                    }
                } else {
                    ZStack {
                        HStack {
                            TextField(title, text: $text)
                            Spacer()
                        }
                        if secureField {
                            HStack {
                                Spacer()
                                Image(systemName: showPassword ? "eye" : "eye.slash")
                                    .resizable()
                                    .scaledToFit()
                                    .opacity(0.8)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        showPassword.toggle()
                                    }
                                    .frame(width: 25, height: 25)
                            }
                        }
                    }
                }
            }
            .keyboardType(keyboardType)
            .onChange(of: text) { newValue in
                if newValue.isEmpty {
                    textChanged = false
                    error = true
                    return
                }
                textChanged = true
                error = false
            }
            .padding(.horizontal, 20)
        }
        .frame(height: 50)
        .onAppear {
            if textFieldType == .password {
                secureField = true
            } else {
                secureField = false
            }
            withAnimation {
                error = false
            }
        }
    }
}

extension UserTextField {
    enum TextFieldType {
        case login
        case email
        case password
        case name
    }
}
