//
//  AuthViewModel.swift
//  AZS
//
//  Created by Паша Терехов on 03.01.2023.
//

import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var dataIsLoading = false
    
    func login(username: String, password: String, completionHandler: @escaping(ResponseResult<(any ResponseProtocol)?, LoadingError?>) -> ()) {
        dataIsLoading = true
        let httpBody = "username=\(username)&password=\(password)".data(using: .utf8)
        let httpMethod = "POST"
        let completion: ((ResponseResult<Data?, LoadingError?>) -> ()) = { response in
            switch response {
            case .success(let data):
                let decodingResult = self.decodeData(action: .login, data: data)
                if decodingResult.0 != nil {
                    completionHandler(.success(decodingResult.0))
                } else {
                    completionHandler(.failture(decodingResult.1))
                }
            case .failture(let error):
                completionHandler(.failture(error))
            }
            self.dataIsLoading = false
        }
        
        // TEST
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let mockData = AuthData(accessToken: "fuck")
//            let mockData: AuthData? = nil
            let mockResponse = AuthResponse(response: true, data: mockData)
            completionHandler(.success(mockResponse))
            self.dataIsLoading = false
        }
        
//        NetworkApi.dataTask(url: Links.Authorization.login, httpMethod: httpMethod, httpBody: httpBody, completion: completion)
    }
    
    func register(username: String, password: String, firstName: String, lastName: String, completionHandler: @escaping(ResponseResult<(any ResponseProtocol)?, LoadingError?>) -> () ) {
        dataIsLoading = true
        let httpBody = "username=\(username)&password=\(password)&firstName=\(firstName)&lastName=\(lastName)".data(using: .utf8)
        let httpMethod = "POST"
        let completion: ((ResponseResult<Data?, LoadingError?>) -> ()) = { response in
            switch response {
            case .success(let data):
                let decodingResult = self.decodeData(action: .register, data: data)
                if decodingResult.0 != nil {
                    completionHandler(.success(decodingResult.0))
                } else {
                    completionHandler(.failture(decodingResult.1))
                }
            case .failture(let error):
                completionHandler(.failture(error))
            }
            self.dataIsLoading = false
        }
        // TEST
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let mockData = AuthData(accessToken: "fuck")
//            let mockData: AuthData? = nil
            let mockResponse = AuthResponse(response: true, data: mockData)
            completionHandler(.success(mockResponse))
            self.dataIsLoading = false
        }
//        NetworkApi.dataTask(url: Links.Authorization.register, httpMethod: httpMethod, httpBody: httpBody, completion: completion)
    }
    
    private func decodeData(action: NetAction, data: Data?) -> ((any ResponseProtocol)?, LoadingError?) {
        if data == nil {
            return (nil, LoadingError.DataIsNil)
        }
        switch action {
        case .login:
            do {
                let json = try JSONDecoder().decode(AuthResponse.self, from: data!)
                return (json, nil)
            } catch {
                return (nil, LoadingError.DecodingError)
            }
        case .register:
            do {
                let json = try JSONDecoder().decode(AuthResponse.self, from: data!)
                return (json, nil)
            } catch {
                return (nil, LoadingError.DecodingError)
            }
        }
    }
}

extension AuthViewModel {
    enum NetAction {
        case login
        case register
    }
}
