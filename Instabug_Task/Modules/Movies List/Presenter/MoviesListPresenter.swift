//
//  MoviesListPresenter.swift
//  Instabug_Task
//
//  Created by Islam Soliman on 2/25/19.
//  Copyright © 2019 Islam Soliman. All rights reserved.
//

import UIKit

class MoviesListPresenter {

    //MARK: - Variables
    private weak var scene: MoviesListViewProtocol?
    var movies: [Movie] = []
    var upComingPage = 1
    var totalPages: Int?
    private var isLoadingMovies = false
    
    //MARK: - Constants
    private let service: NetworkManager
    
    //MARK: - Initializers
    init(scene: MoviesListViewProtocol, service: NetworkManager = NetworkManager()) {
        
        self.scene = scene
        self.service = service
    }
    
    //MARK: - Presenter API
    func fetchMovies() {
        
        isLoadingMovies = true
        
        let path : String = String(format: "http://api.themoviedb.org/3/discover/movie?api_key=acea91d2bff1c53e6604e4985b6989e2&page=%d", upComingPage)
        
        service.getModel(of: path, success: { [weak self] (page: MoviesPage) in
            
            guard let weakSelf = self else { return }
            
            weakSelf.upComingPage += 1
            weakSelf.totalPages = page.totalPages
            weakSelf.movies.append(contentsOf: page.movies ?? [])
            let viewModels = weakSelf.map(movies: weakSelf.movies)
            weakSelf.scene?.moviesDidLoadSuccefully(with: viewModels)
            
            }, failure: { [weak self] (errorMsg) in
                
                self?.scene?.loadingMoviesDidFail(with: errorMsg)
                
        }) { [weak self] in
            
            self?.isLoadingMovies = false
            self?.scene?.loadMoviesDidFinish()
        }
        
    }
    
    func addNewMovieAction() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller: AddNewMovieViewController = storyboard.instantiateViewController(withIdentifier: "AddNewMovieViewController") as! AddNewMovieViewController
        
        let addMoviePresenter = AddNewMoviePresenter(scene: controller, movieDelegate: self)
        controller.presenter = addMoviePresenter
        
        scene?.push(viewController: controller)
    }
    
    func loadMoreMovies() {
        
        guard let totalPages = totalPages else {
            
            startLoadMoreMovies()
            return
        }
        
        if totalPages >= upComingPage {
            
            startLoadMoreMovies()
        }

    }
    
    func saveMyMovie(_ movie: MovieViewModel) {
        
        scene?.movieOfMineDidSaveSuccefully(movie)
    }
    
    //MARK: - Private Methods
    func map(movies: [Movie]) -> [MovieViewModel] {
        
        return movies.map { MovieViewModel(title: $0.title ?? "", overview: $0.overview ?? "", date: $0.releaseDate ?? "", posterPath: $0.posterPath ?? "", poster: nil) }
    }
    
    private func startLoadMoreMovies() {
        
        if !isLoadingMovies {
            
            scene?.startLoadingMoreMovies()
            fetchMovies()
        }
        
    }
    
}
