//
//  CoreDataManager.swift
//  moviesapp
//
//  Created by Carlos V on 16/06/23.
//

import Foundation
import CoreData

class CoreDataManager {
    private let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "MoviesModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    func saveMovies(_ movies: [Movie]) {
        persistentContainer.performBackgroundTask { context in
            for movie in movies {
                let movieEntity = MovieEntity(context: context)
                movieEntity.adult = movie.adult
                movieEntity.backdropPath = movie.backdropPath
                movieEntity.genreIds = movie.genreIds
                movieEntity.id = movie.id
                movieEntity.originalLanguage = movie.originalLanguage
                movieEntity.originalTitle = movie.originalTitle
                movieEntity.overview = movie.overview
                movieEntity.popularity = movie.popularity
                movieEntity.posterPath = movie.posterPath
                movieEntity.releaseDate = movie.releaseDate
                movieEntity.title = movie.title
                movieEntity.video = movie.video
                movieEntity.voteAverage = movie.voteAverage
                movieEntity.voteCount = movie.voteCount
            }
            
            do {
                try context.save()
            } catch {
                print("Failed to save movies to Core Data: \(error)")
            }
        }
    }
    
//    func loadSavedMovies() -> [Movie] {
//        let fetchRequest: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
//
//        do {
//            let movieEntities = try persistentContainer.viewContext.fetch(fetchRequest)
//            return movieEntities.map {
//                Movie(title: $0.title, year: $0.year, posterURL: $0.posterURL)
//            }
//        } catch {
//            print("Failed to load saved movies from Core Data: \(error)")
//            return []
//        }
//    }
    func loadSavedMovies() -> [Movie] {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "MovieEntity")
        fetchRequest.sortDescriptors = []

        do {
            let movieEntities = try persistentContainer.viewContext.fetch(fetchRequest) as! [MovieEntity]
            return movieEntities.map {
                Movie(adult: $0.adult, backdropPath: $0.backdropPath, genreIds: $0.genreIds, id: $0.id, originalLanguage: $0.originalLanguage, originalTitle: $0.originalTitle, overview: $0.overview, popularity: $0.popularity, posterPath: $0.posterPath, releaseDate: $0.releaseDate, title: $0.title, video: $0.video, voteAverage: $0.voteAverage, voteCount: $0.voteCount)
            }
        } catch {
            print("Failed to load saved movies from Core Data: \(error)")
            return []
        }
    }



}
