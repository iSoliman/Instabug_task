//
//  MoviesListSceneMock.swift
//  Instabug_TaskTests
//
//  Created by Islam Soliman on 2/27/19.
//  Copyright © 2019 Islam Soliman. All rights reserved.
//

import UIKit
@testable import Instabug_Task

class MoviesListSceneMock: MoviesListViewProtocol {
    
    func moviesDidLoadSuccefully(with movies: [MovieViewModel]) {
        
        print("moviesDidLoadSuccefully")
    }
    
    func movieOfMineDidSaveSuccefully(_ movie: MovieViewModel) {
        
        print("movieOfMineDidSaveSuccefully")
    }
    
    func push(viewController controller: UIViewController) {
        
        print("push")
    }
    
    func startLoadingMovies() {
        
        print("startLoadingMovies")
    }
    
    func startLoadingMoreMovies() {
        
        print("startLoadingMoreMovies")
    }
    
    func loadMoviesDidFinish() {
        
        print("loadMoviesDidFinish")
    }
    
    func loadingMoviesDidFail(with errorMsg: String) {
        
        print("loadingMoviesDidFail")
    }

}
