//
//  ProfileWrapper.swift
//  AZS
//
//  Created by Паша Терехов on 03.01.2023.
//

import SwiftUI

struct ProfileWrapper: View {
    @EnvironmentObject private var profile: Profile
    
    var body: some View {
        ZStack {
            if !profile.isSignedIn {
                AuthView()
            } else {
                CustomNavigationStack {
                    ProfileView()
                }
            }
        }
    }
}
