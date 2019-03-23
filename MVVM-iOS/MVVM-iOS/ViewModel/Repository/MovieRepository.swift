//
//  MoviesRepository.swift
//  MVVM-iOS
//
//  Created by Sagar More on 24/03/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

struct MovieRepository {
    private let endPoint = "/movie/popular?"
    
    /// gets popular movies from server
    func getMovies( completionHandler : @escaping (Data?, Error?) -> Void) {
        NetworkManager.shared.startRequest(endPoint, httpMethod: .get) { (data, err) in
            completionHandler(data, err)
        }
    }
}
