//
//  MoviesListViewModels.swift
//  Instabug_Task
//
//  Created by Islam Soliman on 2/25/19.
//  Copyright © 2019 Islam Soliman. All rights reserved.
//

import Foundation
import UIKit

struct MoviesListSection {
    
    let title: String
    var movies: [MovieViewModel]
}

struct MovieViewModel {
    
    let title: String
    let overview: String
    let date: String
    let posterPath: String
    let poster: UIImage?
    
}
