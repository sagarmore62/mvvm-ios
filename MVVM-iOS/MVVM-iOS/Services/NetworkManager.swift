//
//  NetworkManager.swift
//  MVVM-iOS
//
//  Created by Sagar More on 22/03/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

enum HttpMethod : String {
    case post = "POST"
    case get = "GET"
}

class NetworkManager  {
    static let shared = NetworkManager()
    
    private init() {
    }
    
    func startRequest(_ url : String, httpMethod : HttpMethod, completionHandler : @escaping (Data?, Error?) -> Void) {
        let finalUrl = Constants.baseUrl + url + Constants.keyPath + Constants.apiKey
        guard let URL = URL(string: finalUrl) else {
            completionHandler(nil, nil)
            return
        }
        var request = URLRequest(url: URL)
        request.httpMethod = httpMethod.rawValue
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            completionHandler(data, error)
        }.resume()
    }
}
