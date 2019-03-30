//
//  MovieViewModel.swift
//  MVVM-iOS
//
//  Created by Sagar More on 24/03/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import UIKit

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
    let description : NSMutableAttributedString
    private let model : MovieObject
    
    ///Created dependency injection for view model
    init(_ model : MovieObject) {
        self.model = model
        //format full image path
        imagePath = Constants.domainImage + "w300" + model.poster_path
        //format description of movie as : movie title (vote average)
        let attributedString = NSMutableAttributedString(string: model.title)
        attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12.0)], range: NSMakeRange(0, attributedString.length))
        let attributedVote = NSAttributedString(string: " (" + model.vote_average.description  + ")", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0)])
        attributedString.append(attributedVote)
        description = attributedString
    }
    
    /// Get model data for analytics event, if needed.
    func getModel() -> MovieObject {
        return model
    }
}
