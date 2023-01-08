//
//  UserDefaults.swift
//  AZS
//
//  Created by Паша Терехов on 08.01.2023.
//

import Foundation

extension UserDefaults {
    // очистка данных из хранилища
    func clearData(in profile: Profile) {
        profile.password = ""
        profile.username = ""
        profile.accessToken = ""
        profile.lastName = ""
        profile.firstName = ""
        setData(from: profile)
    }
    // сохранение новых данных в хранилище
    func setData(from profile: Profile) {
        setValue(profile.password, forKey: "profile.password")
        setValue(profile.username, forKey: "profile.username")
        setValue(profile.accessToken, forKey: "profile.accessToken")
        setValue(profile.lastName, forKey: "profile.lastName")
        setValue(profile.firstName, forKey: "profile.firstName")
    }
    // получение данных из хранилища
    func updateData(to profile: Profile) {
        profile.password = value(forKey: "profile.password") as? String ?? ""
        profile.username = value(forKey: "profile.username") as? String ?? ""
        profile.accessToken = value(forKey: "profile.accessToken") as? String ?? ""
        profile.lastName = value(forKey: "profile.lastName") as? String ?? ""
        profile.firstName = value(forKey: "profile.firstName") as? String ?? ""
    }
}
