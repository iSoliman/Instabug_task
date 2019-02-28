//
//  Instabug_TaskTests.swift
//  Instabug_TaskTests
//
//  Created by Islam Soliman on 2/23/19.
//  Copyright © 2019 Islam Soliman. All rights reserved.
//

import XCTest
@testable import Instabug_Task


class MoviesListPresenterTest: XCTestCase {
    
    var presenter: MoviesListPresenter!
    var network: MovieListNetworkManagerMock!
    
    override func setUp() {
        super.setUp()
        
        let scene = MoviesListSceneMock()
        network = MovieListNetworkManagerMock()
        presenter = MoviesListPresenter(scene: scene, service: network)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchMoviesSuccess() {
        
        network.testCase = .twentyMovies
        presenter.fetchMovies()
        XCTAssert(presenter.upComingPage == 2, "wrong current page Value")
        XCTAssert(presenter.movies.count == 20, "wrong movies count")
    }
    
    func testFetchMoviesFail() {
        
        network.testCase = .failure
        presenter.fetchMovies()
        XCTAssert(presenter.upComingPage == 1, "wrong current page Value")
        XCTAssert(presenter.movies.count == 0, "wrong movies count")
    }
    
    func testLoadMoreMovies() {
        
        network.testCase = .twentyMovies
        presenter.fetchMovies()
        presenter.loadMoreMovies()
        
        XCTAssert(presenter.upComingPage == 3, "wrong current page Value")
        XCTAssert(presenter.movies.count == 40, "wrong movies count of \(presenter.movies.count)")
    }
    
    func testLoadMoreMoviesWithFail() {
        
        network.testCase = .twentyMovies
        presenter.fetchMovies()
        
        network.testCase = .failure
        presenter.loadMoreMovies()
        presenter.loadMoreMovies()
        
        XCTAssert(presenter.movies.count == 20, "wrong movies count of \(presenter.movies.count)")
        XCTAssert(presenter.upComingPage == 2, "wrong upcoming page Value of \(presenter.upComingPage)")
        
        
    }
    
    func testGetAllPages() {
        
        network.testCase = .twentyMovies
        presenter.fetchMovies()
        
        for _ in presenter.upComingPage...presenter.totalPages! + 10 {
            
            presenter.loadMoreMovies()
        }
        
        XCTAssert(presenter.movies.count == 20 * presenter.totalPages!, "wrong movies count of \(presenter.movies.count)")
        
        XCTAssert(presenter.upComingPage == presenter.totalPages! + 1, "wrong upcoming page Value of \(presenter.upComingPage)")
    }
    
    func testStartLoadingMoviesFromLoadMore() {
        
        network.testCase = .twentyMovies
        presenter.loadMoreMovies()
        
        XCTAssert(presenter.movies.count == 20 , "wrong movies count of \(presenter.movies.count)")
        
        XCTAssert(presenter.upComingPage == 2, "wrong upcoming page Value of \(presenter.upComingPage)")
        
    }
    
    func testViewModelMapping() {
        
        let movies = [Movie](repeating: network.getStaticMovie(), count: 10)
        
        let viewModels = presenter.map(movies: movies)
        XCTAssert(viewModels.count == movies.count, "mapping faulty")
        
        
        
    }
    
}
