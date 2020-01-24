//
//  Movie.swift
//  MovieNightApp
//
//  Created by Michael Flowers on 1/23/20.
//  Copyright © 2020 Michael Flowers. All rights reserved.
//

import Foundation

class Movie: Codable {
    let voteAverage: Double
    let title: String
    let genreIds: [Int]
    let poster_path: String
    let popularity: Double
    let overview: String
}
