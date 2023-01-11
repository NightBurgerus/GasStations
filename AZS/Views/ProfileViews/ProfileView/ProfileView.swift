//
//  ProfileView.swift
//  AZS
//
//  Created by Паша Терехов on 08.01.2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var profile: Profile
    @EnvironmentObject private var controllers: Controllers
    @Environment(\.colorScheme) private var colorScheme
    @State private var showsActionSheet = false
    @State private var actionSheet: ActionSheet!
    @StateObject private var profileVM = ProfileViewModel()
    @State private var showsToast = false
    @State private var toastMessage = ""
    @State private var action: Int? = nil
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                UserInfo()

                DeleteButton {
                    deleteAccount()
                }
                
                ExitButton {
                    exitAccount()
                }
                
                Spacer()
            }.padding(20)
            
            if showsToast {
                VStack {
                    Spacer()
                    Toast(isShowing: $showsToast, text: toastMessage)
                }
            }
            
            if profileVM.dataIsLoading {
                LoadingScreen()
            }
            
            NavigationLink(destination: SettingsView(), tag: 1, selection: $action) {}
        }
        .introspectNavigationController({ navigationController in
            guard let nc = navigationController else {
                return
            }
            nc.navigationBar.isHidden = true
        })
        .actionSheet(isPresented: $showsActionSheet) {
            actionSheet
        }
        .onAppear {
            configureView()
        }
    }
    
    private func configureView() {
        action = nil
    }
    
    private func UserInfo() -> some View {
        HStack {
            UserIcon()
            UsernameInfo().padding(.leading, 10)
            SettingsButton()
            Spacer()
        }
    }
    
    private func SettingsButton() -> some View {
        VStack {
            Group {
                if colorScheme == .dark {
                    Res.images.settingsWhite
                } else {
                    Res.images.settingsBlack
                }
            }
            .frame(width: 50, height: 50)
            .contentShape(Rectangle())
            .onTapGesture {
                action = 1
            }
        }
    }
    
    private func UserIcon() -> some View {
        ZStack {
            Circle().fill(Color.blue).frame(width: 150, height: 150)
            BoldText(String(profile.firstName.prefix(1)) + String(profile.lastName.prefix(1)), fontSize: .s24).foregroundColor(Res.colors.white)
        }
    }
    private func UsernameInfo() -> some View {
        VStack {
            HStack {
                BoldText(Res.strings.profile.username, fontSize: .s16)
                Spacer()
            }
            HStack {
                RegularText(profile.username, fontSize: .s16)
                Spacer()
            }.padding(.bottom, 10)
            HStack {
                BoldText(Res.strings.profile.firstName, fontSize: .s16)
                Spacer()
            }
            HStack {
                RegularText(profile.firstName, fontSize: .s16)
                Spacer()
            }.padding(.bottom, 10)
            HStack {
                BoldText(Res.strings.profile.lastName, fontSize: .s16)
                Spacer()
            }
            HStack {
                RegularText(profile.lastName, fontSize: .s16)
                Spacer()
            }.padding(.bottom, 10)
        }
    }
    
    private func EditButton(_ completion: @escaping() -> ()) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5).fill(Color.blue).frame(height: 40).padding(.horizontal, 10)
            BoldText(Res.strings.profile.edit, fontSize: .s16).foregroundColor(.white)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            completion()
        }
    }
    private func DeleteButton(_ completion: @escaping() -> ()) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5).fill(Color.red).frame(height: 40).padding(.horizontal, 10)
            BoldText(Res.strings.profile.delete, fontSize: .s16).foregroundColor(.white)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            actionSheet = ActionSheet(title: Text(Res.strings.profile.deleteSheet), buttons: [.destructive(Text(Res.strings.profile.yes), action: {
                showsActionSheet = false
                completion()
            }), .cancel(Text(Res.strings.profile.no), action: {
                showsActionSheet = false
            })])
            showsActionSheet = true
        }
    }
    
    private func ExitButton(_ completion: @escaping() -> ()) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(colorScheme == .dark ? Res.colors.darkGray : Res.colors.lightGray)
                .frame(height: 40)
                .padding(.horizontal, 10)
            BoldText(Res.strings.profile.exit, fontSize: .s16).foregroundColor(.red)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            actionSheet = ActionSheet(title: Text(Res.strings.profile.exitSheet), buttons: [.destructive(Text(Res.strings.profile.yes), action: {
                showsActionSheet = false
                completion()
            }), .cancel(Text(Res.strings.profile.no), action: {
                showsActionSheet = false
            })])
            showsActionSheet = true
        }
    }
    
    private func deleteAccount() {
        profileVM.delete(byToken: profile.accessToken) { response in
            switch response {
            case .success(let data):
                if !data!.response {
                    toastMessage = Res.strings.toast.deletingAccountError
                    withAnimation {
                        showsToast = true
                    }
                    return
                }
                toastMessage = Res.strings.toast.deletingSuccess
                withAnimation {
                    showsToast = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    UserDefaults.standard.clearData(in: profile)
                }
            case .failture(_):
                toastMessage = Res.strings.toast.deletingAccountError
                withAnimation {
                    showsToast = true
                }
            }
        }
    }
    
    private func exitAccount() {
        profileVM.logout(withToken: profile.accessToken) { response in
            switch response {
            case .success(let data):
                if !data!.response {
                    toastMessage = Res.strings.toast.exitError
                    withAnimation {
                        showsToast = true
                    }
                    return
                }
                toastMessage = Res.strings.toast.exitSuccess
                withAnimation {
                    showsToast = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    UserDefaults.standard.clearData(in: profile)
                }
            case .failture(_):
                toastMessage = Res.strings.toast.exitError
                withAnimation {
                    showsToast = true
                }
            }
        }
    }
}
