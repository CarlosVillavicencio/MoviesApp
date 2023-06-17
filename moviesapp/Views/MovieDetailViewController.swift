//
//  MovieDetailViewController.swift
//  moviesapp
//
//  Created by Carlos V on 17/06/23.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: Movie?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOriginalLanguage: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie {
            lblTitle.text = movie.title
            lblOriginalLanguage.text = "Original Language: \(movie.originalLanguage)"
            lblOverview.text = movie.overview
            loadImage(movie: movie, imageView: self.imgMovie)
        }
    }

    func loadImage(movie: Movie, imageView :UIImageView) {
        let baseURLString = "https://image.tmdb.org/t/p/w500/"
        let posterPathMovie = movie.posterPath ?? ""
        let posterURLString = baseURLString + posterPathMovie
        if let posterURL = URL(string: posterURLString) {
            URLSession.shared.dataTask(with: posterURL) { data, response, error in
                if let error = error {
                    print("Error al descargar la imagen: \(error)")
                    return
                }
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageView.image = image
                        imageView.layer.shadowRadius = 5
                        imageView.layer.cornerRadius = 5
                        imageView.clipsToBounds = true
                        imageView.layer.masksToBounds = true
                    }
                }
            }.resume()
        }
    }
}
