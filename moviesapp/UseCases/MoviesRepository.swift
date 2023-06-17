//
//  MoviesRepository.swift
//  moviesapp
//
//  Created by Carlos V on 16/06/23.
//

import Foundation

protocol MoviesRepository {
    typealias SearchCompletion = (Result<[Movie], Error>) -> Void
    
    func searchMovies(query: String, completion: @escaping SearchCompletion)
}
