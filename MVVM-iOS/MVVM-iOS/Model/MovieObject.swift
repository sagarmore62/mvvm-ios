//
//  MovieObject.swift
//  MVVM-iOS
//
//  Created by Sagar More on 24/03/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

struct MovieObject : Decodable{
    // title of movie
    let title           : String
    // Image for poster portrait
    let poster_path     : String
    // Average rating
    let vote_average    : Float
}
