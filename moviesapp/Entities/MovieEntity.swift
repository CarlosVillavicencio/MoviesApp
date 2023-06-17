//
//  MovieEntity.swift
//  moviesapp
//
//  Created by Carlos V on 16/06/23.
//

import Foundation

import CoreData

@objc(MovieEntity)
class MovieEntity: NSManagedObject {
    @NSManaged var adult: Bool
    @NSManaged var backdropPath: String?
    @NSManaged var genreIds: [Int]
    @NSManaged var id: Int
    @NSManaged var originalLanguage: String
    @NSManaged var originalTitle: String
    @NSManaged var overview: String
    @NSManaged var popularity: Double
    @NSManaged var posterPath: String?
    @NSManaged var releaseDate: String
    @NSManaged var title: String
    @NSManaged var video: Bool
    @NSManaged var voteAverage: Double
    @NSManaged var voteCount: Int
}
