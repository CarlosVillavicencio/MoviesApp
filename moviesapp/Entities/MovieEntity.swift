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
    @NSManaged var title: String
    @NSManaged var year: String
    @NSManaged var posterURL: URL
}
