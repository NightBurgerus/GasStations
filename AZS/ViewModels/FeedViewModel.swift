//
//  FeedViewModel.swift
//  AZS
//
//  Created by Паша Терехов on 08.01.2023.
//

import SwiftUI

class FeedViewModel: ObservableObject {
    @Published var dataIsLoading = false
    
    func getInfo(completionHandler: @escaping(ResponseResult<(any ResponseProtocol)?, LoadingError?>) -> ()) {
        dataIsLoading = true
        let completion: ((ResponseResult<Data?, LoadingError?>) -> ()) = { response in
            switch response {
            case .failture(let error): completionHandler(.failture(error))
            case .success(let data):
                let decodedData = self.decodeData(action: .getNewsList, data: data!)
                if decodedData.0 != nil {
                    completionHandler(.success(decodedData.0))
                } else {
                    completionHandler(.failture(decodedData.1))
                }
            }
            self.dataIsLoading = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            var feed = [FeedData]()
            for i in 0...Int.random(in: 5...10) {
                feed.append(FeedData(id: i, text: "Новость №\(i + 1)"))
            }
            let response = FeedResponse(response: true, data: feed)
            completionHandler(.success(response))
            self.dataIsLoading = false
        }
//        NetworkApi.dataTask(url: Links.Feed.news, completion: completion)
    }
    
    func getDetailInfo(byId id: Int, completionHandler: @escaping(ResponseResult<(any ResponseProtocol)?, LoadingError?>) -> () ) {
        dataIsLoading = true
        let completion: ((ResponseResult<Data?, LoadingError?>) -> ()) = { response in
            switch response {
            case .success(let data):
                let decodedData = self.decodeData(action: .getDetailNews, data: data!)
                if decodedData.0 != nil {
                    completionHandler(.success(decodedData.0))
                } else {
                    completionHandler(.failture(decodedData.1))
                }
            case .failture(let error):
                completionHandler(.failture(error))
            }
            self.dataIsLoading = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            var detailInfo = DetailInfoData(label: "Новость №\(id)", text: "Вчера кто-то спиздил с заправки сникерс", image: nil)
            var response = DetailInfoResposne(response: true, data: detailInfo)
            completionHandler(.success(response))
            self.dataIsLoading = false
        }
//        NetworkApi.dataTask(url: Links.Feed.detail + String(id), completion: completion)
    }
    
    private func decodeData(action: NetActions, data: Data?) -> ((any ResponseProtocol)?, LoadingError?) {
        if data == nil {
            return (nil, .DataIsNil)
        }
        switch action {
        case .getDetailNews:
            do {
                let json = try JSONDecoder().decode(DetailInfoResposne.self, from: data!)
                return (json, nil)
            } catch {
                return (nil, .DecodingError)
            }
        case .getNewsList:
            do {
                let json = try JSONDecoder().decode(FeedResponse.self, from: data!)
                return (json, nil)
            } catch {
                return (nil, .DecodingError)
            }
        }
    }
}

extension FeedViewModel {
    enum NetActions {
        case getNewsList
        case getDetailNews
    }
}
