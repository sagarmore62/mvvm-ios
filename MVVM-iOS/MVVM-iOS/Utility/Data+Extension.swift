//
//  Data+Extension.swift
//  MVVM-Movies
//
//  Created by Sagar More on 22/03/19.
//  Copyright © 2019 Mario Acero. All rights reserved.
//

import Foundation

extension Data {
    //Generic function return Decodable from Data
    func getJsonModel<T: Decodable>(modelType _: T.Type, decodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase, completionHandler: @escaping (_ response: T?, _ error: Error?) -> Void) {
        var model: T?
        var err: Error?
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = decodingStrategy
        do {
            model = try decoder.decode(T.self, from: self)
        } catch {
            err = error
        }
        completionHandler(model, err)
    }
}


