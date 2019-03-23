//
//  MovieViewModel.swift
//  MVVM-iOS
//
//  Created by Sagar More on 24/03/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

protocol ViewModelDelegate : class {
    func reloadTable()
}

class MovieViewModel {
    var list = [MovieObjectViewModel]() {
        didSet {
            delegate?.reloadTable()
        }
    }
    private let repo : MovieRepository?
    weak var delegate: ViewModelDelegate?
    
    init() {
        repo = MovieRepository()
    }
    
    func getMovies() {
        repo?.getMovies( completionHandler: { (data, err) in
            if let newData = data {
                newData.getJsonModel(modelType: MovieList.self, decodingStrategy:JSONDecoder.KeyDecodingStrategy.useDefaultKeys , completionHandler: { (model, error) in
                    if let unwrapped = model {
                        //create movie object view models from movie model
                        let arr = unwrapped.results.map({ MovieObjectViewModel($0)})
                        self.list.append(contentsOf:arr)
                    }
                })
            }
        })
    }
}

struct MovieObjectViewModel {
    let imagePath : String
    let description : String
    
    ///Created dependency injection for view model
    init(_ model : MovieObject) {
        //format full image path
        imagePath = Constants.domainImage + "w300" + model.poster_path
        //format description of movie as : movie title (vote average)
        description = model.title + " (" + model.vote_average.description  + ")"
    }
}
