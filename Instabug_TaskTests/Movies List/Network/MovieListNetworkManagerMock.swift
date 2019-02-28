//
//  MovieListNetworkManagerMock.swift
//  Instabug_TaskTests
//
//  Created by Islam Soliman on 2/27/19.
//  Copyright © 2019 Islam Soliman. All rights reserved.
//

@testable import Instabug_Task

enum NetwokCase {
    
    case success
    case twentyMovies
    case failure

}

class MovieListNetworkManagerMock: NetworkManager {

    var testCase: NetwokCase!
    
    override func getModel<T>(of url: String, success: @escaping (T) -> Void, failure: @escaping (String) -> Void, finished: @escaping () -> Void) where T : Decodable {
        
        switch testCase! {
        case .success:
            let page = MoviesPage(page: 1, totalResult: 20, totalPages: 10, movies: nil)
            let p: T = page as! T
            success(p)
            
        case .twentyMovies:
            let page = MoviesPage(page: 1, totalResult: 20, totalPages: 10, movies: [Movie](repeating: getStaticMovie(), count: 20))
            let p: T = page as! T
            finished()
            success(p)
            
        case .failure:
            finished()
            failure("Failure")
        
        }
        
    }
    
    func getStaticMovie() -> Movie {
        
        return Movie(voteCount: 1, id: 1, video: false, voteAverage: 10, title: "Title", popularity: 10, posterPath: "posterPath", originalLanguage: nil, originalTitle: nil, generIds: nil, backdropPath: nil, adult: nil, overview: "overview", releaseDate: nil)
    }
    
}
