//
//  MovieViewModel.swift
//  MVVM-iOS
//
//  Created by Sagar More on 24/03/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

protocol ViewModelDelegate : class {
    func reloadTable(type: Int)
}

class MovieViewModel {
    var list = [MovieObject]()
    private let repo : MovieRepository?
    weak var delegate: ViewModelDelegate?
    
    init() {
        repo = MovieRepository()
    }
    
    func getMovies() {
        repo?.getMovies(0, completionHandler: { (data, err) in
            if let newData = data {
                newData.getJsonModel(modelType: MovieList.self, decodingStrategy:JSONDecoder.KeyDecodingStrategy.useDefaultKeys , completionHandler: { (model, error) in
                    if let model = model {
                        self.list.append(contentsOf: model.results)
                    }
                })
            }
        })
    }
}
