//
//  MoviesView.swift
//  moviesapp
//
//  Created by Carlos V on 16/06/23.
//

import UIKit
protocol MovieTableViewCellDelegate: AnyObject {
    func didSelectMovie(_ movie: Movie)
}
class MoviesView: UIViewController {
    
    let cellIdentifier = "CustomMovieCell"
    
    private let viewModel: MoviesViewModel
    @IBOutlet weak var tbMovies: UITableView!
    
    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadMovies()
    }
    
    private func setupUI() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 17)
        ]
        let title = NSAttributedString(string: "Movies", attributes: attributes)
        self.navigationItem.title = title.string
        
        tbMovies.dataSource = self
        tbMovies.delegate = self
        
        let nib = UINib(nibName: "MovieTableViewCell", bundle: Bundle(for: MovieTableViewCell.self))
        tbMovies.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func loadMovies() {
        viewModel.searchMovies() { [weak self] error in
            if let error = error {
                print("Error searching movies: \(error)")
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.125) {
                    self?.tbMovies.reloadData()
                }
            }
        }
    }
}

extension MoviesView: UITableViewDelegate, UITableViewDataSource, MovieTableViewCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let totalItems = viewModel.movies.count
        return totalItems / 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MovieTableViewCell
        let itemIndex = indexPath.row * 2
        let firstMovie = viewModel.movies[itemIndex]
        if itemIndex + 1 < viewModel.movies.count {
            let secondMovie = viewModel.movies[itemIndex + 1]
            cell.configure(movieOne: firstMovie, movieTwo: secondMovie)
        } else {
            cell.configure(movieOne: firstMovie)
        }
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        if offsetY > 0 && offsetY + scrollViewHeight >= contentHeight {
            self.loadMovies()
        }
    }
    func didSelectMovie(_ movie: Movie) {
        let movieDetailViewController = MovieDetailViewController()
        movieDetailViewController.movie = movie
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}
