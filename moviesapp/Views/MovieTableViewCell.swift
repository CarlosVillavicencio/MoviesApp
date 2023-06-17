//
//  MovieTableViewCell.swift
//  moviesapp
//
//  Created by Carlos V on 16/06/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitleOne: UILabel!
    @IBOutlet weak var lblTitleTwo: UILabel!
    @IBOutlet weak var imgvOne: UIImageView!
    @IBOutlet weak var imgvTwo: UIImageView!
    
    @IBOutlet weak var ViewRight: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(movieOne: Movie, movieTwo: Movie? = nil) {
        lblTitleOne.text = movieOne.title
        loadImage(movie: movieOne, imageView: self.imgvOne)
        if let movieTwo = movieTwo {
            lblTitleTwo.text = movieTwo.title
            loadImage(movie: movieTwo, imageView: self.imgvTwo)
        } else {
            ViewRight.isHidden = true
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
