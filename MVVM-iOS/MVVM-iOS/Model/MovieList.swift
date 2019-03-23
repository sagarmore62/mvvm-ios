//
//  MovieList.swift
//  MVVM-iOS
//
//  Created by Sagar More on 24/03/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

struct MovieList : Decodable {
    
    // total number of pages in list
    let total_pages    : Int
    // total number of result in request
    let total_results  : Int
    // list of movies in result
    var results        : [MovieObject]
    
}
