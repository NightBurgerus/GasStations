//
//  Settings.swift
//  AZS
//
//  Created by Паша Терехов on 09.01.2023.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var ip = ""
    @State private var port = ""
    
    var body: some View {
        VStack {
            Label()
            SettingsTextField(label: "IP", text: $ip)
            SettingsTextField(label: "Port", text: $port)
            
            SaveButton()
            CloseButton()
            Spacer()
        }
    }
    
    private func Label() -> some View {
        HStack {
            BoldText("Settings", fontSize: .s24)
            Spacer()
        }.padding(20)
    }
    
    private func SettingsTextField(label: String, text: Binding<String>) -> some View {
        VStack(spacing: 10) {
            HStack {
                BoldText(label, fontSize: .s16)
                Spacer()
            }
            UserTextField(title: label, text: text, textFieldType: .digits)
        }.padding([.top, .horizontal], 20)
    }
    
    private func SaveButton() -> some View {
        CustomButton(label: "Save") {
            Links.base = ip.replacingOccurrences(of: ",", with: ".") + ":" + port
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                presentationMode.wrappedValue.dismiss()
            }
        }.padding(.top, 10)
    }
    private func CloseButton() -> some View {
        CustomButton(label: "Close") {
            presentationMode.wrappedValue.dismiss()
        }.padding(.top, 10)
    }
}
