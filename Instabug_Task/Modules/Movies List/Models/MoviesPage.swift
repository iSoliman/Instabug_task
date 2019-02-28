//
//  MyModel.swift
//  Instabug_Task
//
//  Created by Islam Soliman on 2/24/19.
//  Copyright © 2019 Islam Soliman. All rights reserved.
//

import UIKit

struct MoviesPage: Decodable {

    let page: Int?
    let totalResult: Int?
    let totalPages: Int?
    let movies: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        
        case page
        case totalResult = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
}

struct Movie: Decodable {
    
    let voteCount: Int?
    let id: Int?
    let video: Bool?
    let voteAverage: Float?
    let title: String?
    let popularity: Float?
    let posterPath: String?
    let originalLanguage: String?
    let originalTitle: String?
    let generIds: [Int]?
    let backdropPath: String?
    let adult: Bool?
    let overview: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        
        case id, video, title, popularity, adult, overview
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case generIds = "genre_ids"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        
    }
    
}
