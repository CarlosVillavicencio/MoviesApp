//
//  MovieResponse.swift
//  moviesapp
//
//  Created by Carlos V on 16/06/23.
//

import Foundation

struct MovieResponse: Codable {
    let title: String
    let releaseDate: String
    let posterPath: String
    
    var posterURL: URL {
        let baseURL = "https://example.com/posters/"
        return URL(string: baseURL + posterPath)!
    }
}
