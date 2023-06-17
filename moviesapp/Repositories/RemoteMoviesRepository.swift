//
//  RemoteMoviesRepository.swift
//  moviesapp
//
//  Created by Carlos V on 16/06/23.
//

import Foundation

class RemoteMoviesRepository: MoviesRepository {
    private let apiKey = "f46b58478f489737ad5a4651a4b25079"
    
    func searchMovies(query: String, completion: @escaping SearchCompletion) {
        let urlString = "https://api.themoviedb.org/3/movie/upcoming?page=1&api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let moviesResponse = try decoder.decode(MoviesResponse.self, from: data)
                let movies = moviesResponse.results.map {
                    Movie(adult: $0.adult, backdropPath: $0.backdropPath, genreIds: $0.genreIds, id: $0.id, originalLanguage: $0.originalLanguage, originalTitle: $0.originalTitle, overview: $0.overview, popularity: $0.popularity, posterPath: $0.posterPath, releaseDate: $0.releaseDate, title: $0.title, video: $0.video, voteAverage: $0.voteAverage, voteCount: $0.voteCount)
                }
                completion(.success(movies))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
