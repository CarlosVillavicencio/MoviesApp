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
    
    private var page: Int = 0
    private var noMoreMovies: Bool = false
    var movies: [Movie] = []
    
    init(repository: MoviesRepository, coreDataManager: CoreDataManager) {
        self.repository = repository
        self.coreDataManager = coreDataManager
    }
    
    func searchMovies(completion: @escaping (Error?) -> Void) {
        if noMoreMovies {
            return
        }
        page += 1
        repository.searchMovies(query: "\(page)") { [weak self] result in
            switch result {
            case .success(let movies):
                if movies.count == 0 {
                    self?.noMoreMovies = true
                }
                self?.movies += movies
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
