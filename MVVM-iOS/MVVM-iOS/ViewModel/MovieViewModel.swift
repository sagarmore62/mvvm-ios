//
//  MovieViewModel.swift
//  MVVM-iOS
//
//  Created by Sagar More on 24/03/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation


class MovieViewModel {
    var list = [MovieObjectViewModel]()
    private let repo : MovieRepository?
    var isLoading = false
    
    init() {
        repo = MovieRepository()
    }
    
    func getMovies( completionHandler : @escaping ( Error?) -> Void) {
        isLoading = true
        repo?.getMovies( completionHandler: { (data, err) in
            if let newData = data {
                newData.getJsonModel(modelType: MovieList.self, decodingStrategy:JSONDecoder.KeyDecodingStrategy.useDefaultKeys , completionHandler: { (model, error) in
                    if let unwrapped = model {
                        self.transform(unwrapped)
                    }
                    completionHandler(error)
                })
            } else {
                completionHandler(err)
            }
        })
    }
    
    ///transforms model into view model
    func transform(_ model : MovieList) {
        let arr = model.results.map({ MovieObjectViewModel($0)})
        self.list.append(contentsOf:arr)
    }
}

struct MovieObjectViewModel {
    let imagePath : String
    let description : NSMutableAttributedString
    private let model : MovieObject
    
    ///Created dependency injection for view model
    init(_ model : MovieObject) {
        self.model = model
        //format full image path
        imagePath = Constants.domainImage + "w300" + model.poster_path
        //format description of movie as : movie title (vote average)
        let attributedString = NSMutableAttributedString(string: model.title)
        attributedString.addAttributes([NSAttributedString.Key.font : AppTheme.Font.bold], range: NSMakeRange(0, attributedString.length))
        let attributedVote = NSAttributedString(string: " (" + model.vote_average.description  + ")", attributes: [NSAttributedString.Key.font : AppTheme.Font.regular])
        attributedString.append(attributedVote)
        description = attributedString
    }
    
    /// Get model data for if needed.
    func getModel() -> MovieObject {
        return model
    }
}
