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
                movieEntity.title = movie.title
                movieEntity.year = movie.year
                movieEntity.posterURL = movie.posterURL
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
                Movie(title: $0.title, year: $0.year, posterURL: $0.posterURL)
            }
        } catch {
            print("Failed to load saved movies from Core Data: \(error)")
            return []
        }
    }



}
