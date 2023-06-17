//
//  MoviesView.swift
//  moviesapp
//
//  Created by Carlos V on 16/06/23.
//

import UIKit

class MoviesView: UIViewController {
    private let viewModel: MoviesViewModel
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        // Configura el diseño de la tabla, como las celdas, la altura, etc.
        return tableView
    }()
    
    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupUI()
        loadMovies()
        print("moviewview iniciado")
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")
    }
    
    private func loadMovies() {
        viewModel.searchMovies(query: "Action") { [weak self] error in
            if let error = error {
                // Mostrar un mensaje de error o realizar alguna acción de manejo de errores
                print("Error searching movies: \(error)")
            } else {
                print("data recibida")
                if let movies = self?.viewModel.movies {
                    for movie in movies {
                        print("movie")
                        print(movie.title)
                    }
                    print("=========================")
                    print("=========================")
                    print("=========================")
                    print("=========================")
                    print("movies")
                    print(movies)
                } else {
                    print("movies no encontrada")
                }
//                self?.tableView.reloadData()
            }
        }
    }
}

extension MoviesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        
        let movie = viewModel.movies[indexPath.row]
        cell.configure(with: movie)
        
        return cell
    }
}

class MovieTableViewCell: UITableViewCell {
    func configure(with movie: Movie) {
        // Configura la celda con los datos de la película, como el título, el año, etc.
    }
}
