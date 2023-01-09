//
//  Requests.swift
//  AZS
//
//  Created by Паша Терехов on 03.01.2023.
//

import Foundation

class NetworkApi {
    static func dataTask(url: String, httpMethod: String = "GET", httpBody: Data? = nil, completion: @escaping(ResponseResult<Data?, LoadingError?>) -> ()) {
        guard let url = URL(string: url) else {
            DispatchQueue.main.async {
                completion(.failture(.InvalidURL))
            }
            return
        }
        var request = URLRequest(url: url)
        request.httpBody = httpBody
        request.httpMethod = httpMethod
        
        URLSession.shared.dataTask(with: request) { jsonData, response, error in
            guard error == nil else {
                print("~ error: ", error!.localizedDescription)
                DispatchQueue.main.async {
                    completion(.failture(.Error))
                }
                return
            }
            
            let statusCode = (response as! HTTPURLResponse).statusCode
            guard 200...299 ~= statusCode else {
                print("~ status code: ", statusCode)
                DispatchQueue.main.async {
                    completion(.failture(.InvalidStatusCode))
                }
                return
            }
            
            if let data = jsonData {
                print("~ data: ", data)
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failture(.DataIsNil))
                }
            }
        }.resume()
    }
}
