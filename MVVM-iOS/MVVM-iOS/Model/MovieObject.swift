//
//  MovieObject.swift
//  MVVM-iOS
//
//  Created by Sagar More on 24/03/19.
//  Copyright © 2019 Sagar More. All rights reserved.
//

import Foundation

struct MovieObject : Decodable{
    let title           : String
    let poster_path     : String
    let vote_average    : Float
}
