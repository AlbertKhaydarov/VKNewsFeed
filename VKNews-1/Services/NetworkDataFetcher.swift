//
//  NetworkDataFetcher.swift
//  VKNews
//
//  Created by Admin on 28.06.2023.
//

import Foundation

protocol DataFetcher {
    
    func getFeed(nextBatchFrom: String?, response: @escaping (FeedResponse?) -> Void)
    func getUser(response: @escaping (UserResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {

    private let authService: AuthService
    let networking: Networking
    
    init(networking: Networking, authService: AuthService = SceneDelegate.shared().authService) {
        self.networking = networking
        self.authService = authService
    }
  
    
    func getUser(response: @escaping (UserResponse?) -> Void) {
        guard let userId = authService.userId else {return}
        let params = ["user_ids": userId, "fields": "photo_100"]
        networking.request(from: API.user, params: params) { data, error in
            if let error = error {
                print("Error recived request data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJson(type: UserResponseWrapped.self, from: data)
            response(decoded?.response.first)
        }
    }
    
    func getFeed(nextBatchFrom: String?, response: @escaping (FeedResponse?) -> Void) {
        
        var params = ["filters": "post, photo"]
        params["start_from"] = nextBatchFrom
        networking.request(from: API.newsFeed, params: params) { data, error in
            if let error = error {
                print("Error recived request data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJson(type: FeedResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    private func decodeJson<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else {return nil}
        return response
    }
}
