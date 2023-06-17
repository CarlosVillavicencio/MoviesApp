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
                    Movie(title: $0.title, year: $0.releaseDate, posterURL: $0.posterURL)
                }
                completion(.success(movies))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
