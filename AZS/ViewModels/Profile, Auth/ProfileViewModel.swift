//
//  ProfileViewModel.swift
//  AZS
//
//  Created by Паша Терехов on 03.01.2023.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var dataIsLoading = false
    
    func getPersonalData(withToken token: String, completionHandler: @escaping(ResponseResult<(any ResponseProtocol)?, LoadingError?>) -> () = { _ in }) {
        self.dataIsLoading = true
        print("~ get personalData")
        let httpBody = "Access-Token=\(token)".data(using: .utf8)
        let httpMethod = "POST"
        let completion: ((ResponseResult<Data?, LoadingError?>) -> ()) = { response in
            DispatchQueue.main.async {
                self.dataIsLoading = false
                switch response {
                case .success(let data):
                    let decodedData = self.decodeData(action: .getPersonalData, data: data!)
                    if decodedData.0 != nil {
                        completionHandler(.success(decodedData.0))
                    } else {
                        completionHandler(.failture(decodedData.1))
                    }
                case .failture(let error):
                    completionHandler(.failture(error))
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dataIsLoading = false
            let data = ProfileData(firstName: "First", lastName: "Last")
            let response = ProfileResponse(response: true, data: data)
            completionHandler(.success(response))
        }
//        NetworkApi.dataTask(url: Links.Profile.getProfile, httpMethod: httpMethod, httpBody: httpBody, completion: completion)
    }
    
    func logout(withToken token: String, completionHandler: @escaping(ResponseResult<(any ResponseProtocol)?, LoadingError?>) -> ()) {
        self.dataIsLoading = true
        let completion: ((ResponseResult<Data?, LoadingError?>) -> ()) = { response in
            DispatchQueue.main.async {
                self.dataIsLoading = false
                switch response {
                case .success(let data):
                    let decodedData = self.decodeData(action: .logout, data: data!)
                    if decodedData.0 != nil {
                        completionHandler(.success(decodedData.0))
                    } else {
                        completionHandler(.failture(decodedData.1))
                    }
                case .failture(let error): completionHandler(.failture(error))
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dataIsLoading = false
            completionHandler(.failture(.Error))
        }
//        NetworkApi.dataTask(url: Links.Profile.logout, completion: completion)
    }
    
    func delete(byToken token: String, completionHandler: @escaping(ResponseResult<(any ResponseProtocol)?, LoadingError?>) -> () ) {
        dataIsLoading = true
        let httpData = "Api-token=\(token)".data(using: .utf8)
        let httpMethod = "POST"
        let completion: ((ResponseResult<Data?, LoadingError?>) -> ()) = { response in
            switch response {
            case .success(let data):
                let decodedData = self.decodeData(action: .delete, data: data!)
                if decodedData.0 != nil {
                    completionHandler(.success(decodedData.0))
                } else {
                    completionHandler(.failture(decodedData.1))
                }
            case .failture(let error): completionHandler(.failture(error!))
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dataIsLoading = false
            completionHandler(.success(BaseResponse(response: true, data: EmptyData())))
        }
//        NetworkApi.dataTask(url: Links.Profile.delProfile, httpMethod: httpMethod, httpBody: httpData,  completion: completion)
    }
    
    private func decodeData(action: NetAction, data: Data?) -> ((any ResponseProtocol)?, LoadingError?) {
        if data == nil {
            return (nil, .DataIsNil)
        }
        switch action {
        case .getPersonalData:
            do {
                let json = try JSONDecoder().decode(ProfileResponse.self, from: data!)
                return (json, nil)
            } catch {
                return (nil, .DecodingError)
            }
        case .logout:
            do {
                let json = try JSONDecoder().decode(BaseResponse.self, from: data!)
                return (json, nil)
            } catch {
                return (nil, .DecodingError)
            }
        case .delete:
            do {
                let json = try JSONDecoder().decode(BaseResponse.self, from: data!)
                return (json, nil)
            } catch {
                return (nil, .DecodingError)
            }
        }
    }
}

extension ProfileViewModel {
    private enum NetAction {
        case getPersonalData
        case logout
        case delete
    }
}

extension Int: ResponseProtocol {
    var response: Bool {
        true
    }
    
    var data: AnyHashable {
        1
    }
}
