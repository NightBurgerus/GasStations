//
//  MapViewModel.swift
//  AZS
//
//  Created by Паша Терехов on 09.01.2023.
//

import SwiftUI

class MapViewModel: ObservableObject {
    @Published var dataIsLoading = false
    
    func getStations(completionHandler: @escaping(ResponseResult<(any ResponseProtocol)?, LoadingError?>) -> ()) {
        dataIsLoading = true
        let completion: ((ResponseResult<Data?, LoadingError?>) -> ()) = { response in
            switch response {
            case .failture(let error): completionHandler(.failture(error))
            case .success(let data):
                let decodedData = self.decodeData(data)
                print("~ decodedData: ", decodedData)
                if decodedData.0 != nil {
                    completionHandler(.success(decodedData.0))
                } else {
                    completionHandler(.failture(decodedData.1))
                }
            }
            self.dataIsLoading = false
        }
        
        NetworkApi.dataTask(url: Links.Map.points, completion: completion)
    }
    
    private func decodeData(_ data: Data?) -> ((any ResponseProtocol)?, LoadingError?) {
        if data == nil {
            return (nil, .DataIsNil)
        }
        
        do {
            let json = try JSONDecoder().decode(GasStationResponse.self, from: data!)
            return (json, nil)
        } catch {
            print("~ decoding error: ", error)
            return (nil, .DecodingError)
        }
    }
}

