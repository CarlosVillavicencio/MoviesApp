//
//  MoviesViewModel.swift
//  moviesapp
//
//  Created by Carlos V on 16/06/23.
//

import Foundation
import CoreData

class MoviesViewModel {
    private let repository: MoviesRepository
    private let coreDataManager: CoreDataManager
    
    var movies: [Movie] = []
    
    init(repository: MoviesRepository, coreDataManager: CoreDataManager) {
        self.repository = repository
        self.coreDataManager = coreDataManager
    }
    
    func searchMovies(query: String, completion: @escaping (Error?) -> Void) {
        repository.searchMovies(query: query) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                self?.coreDataManager.saveMovies(movies)
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func loadSavedMovies() {
        movies = coreDataManager.loadSavedMovies()
    }
}
