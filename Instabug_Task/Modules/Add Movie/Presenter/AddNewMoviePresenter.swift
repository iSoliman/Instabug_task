//
//  AddNewMoviePresenter.swift
//  Instabug_Task
//
//  Created by Islam Soliman on 2/25/19.
//  Copyright © 2019 Islam Soliman. All rights reserved.
//

import UIKit

class AddNewMoviePresenter {

    // MARK: - Variables
    weak var scene: AddNewMovieSceneProtocol?
    let movieDelegate: MoviesListPresenter
    
    // MARK: - Initializer
    init(scene: AddNewMovieSceneProtocol, movieDelegate: MoviesListPresenter) {
        
        self.scene = scene
        self.movieDelegate = movieDelegate
    }
    
    // MARK: - Presenter API
    func saveMovie(with title: String?, overview: String?, releaseDate: Date, poster: UIImage?) {
        
        
        let formattedDate = Utilities.formattedText(fromDate: releaseDate)
        let movie = MovieViewModel(title: title ?? "", overview: overview ?? "", date: formattedDate, posterPath: "", poster: poster)
        movieDelegate.saveMyMovie(movie)
        
    }
    
}


