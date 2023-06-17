//
//  MovieTableViewCell.swift
//  moviesapp
//
//  Created by Carlos V on 16/06/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    weak var delegate: MovieTableViewCellDelegate?
    
    private var movieOne: Movie? = nil
    private var movieTwo: Movie? = nil
    
    @IBOutlet weak var lblTitleOne: UILabel!
    @IBOutlet weak var lblTitleTwo: UILabel!
    @IBOutlet weak var imgvOne: UIImageView!
    @IBOutlet weak var imgvTwo: UIImageView!
    
    @IBOutlet weak var ViewRight: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(movieOne: Movie, movieTwo: Movie? = nil) {
        self.movieOne = movieOne
        lblTitleOne.text = movieOne.title
        loadImage(movie: movieOne, imageView: self.imgvOne)
        if let movieTwo = movieTwo {
            lblTitleTwo.text = movieTwo.title
            loadImage(movie: movieTwo, imageView: self.imgvTwo)
            self.movieTwo = movieTwo
        } else {
            ViewRight.isHidden = true
        }
        delegate?.didSelectMovie(movieOne)
        
        let tapGestureOne = UITapGestureRecognizer(target: self, action: #selector(imageOneTapped))
        imgvOne.addGestureRecognizer(tapGestureOne)
        imgvOne.isUserInteractionEnabled = true
        let tapGestureTwo = UITapGestureRecognizer(target: self, action: #selector(imageTwoTapped))
        imgvTwo.addGestureRecognizer(tapGestureTwo)
        imgvTwo.isUserInteractionEnabled = true
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
    
    @objc func imageOneTapped() {
        delegate?.didSelectMovie(self.movieOne!)
    }
    @objc func imageTwoTapped() {
        if let movieTwo = self.movieTwo {
            delegate?.didSelectMovie(movieTwo)
        }
    }
}
