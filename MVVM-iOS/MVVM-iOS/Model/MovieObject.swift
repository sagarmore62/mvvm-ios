//
//  MovieObject.swift
//  MVVM-iOS
//
//  Created by Sagar More on 24/03/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

struct MovieObject : Decodable{
    // id of movie from db
    let id              : Int
    // title of movie
    let title           : String
    /// Image for poster portrait
    let poster_path     : String
}
