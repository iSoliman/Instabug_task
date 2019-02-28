//
//  ApiURLs.swift
//  Instabug_Task
//
//  Created by Islam Soliman on 2/28/19.
//  Copyright © 2019 Islam Soliman. All rights reserved.
//

import UIKit

class ApiURLs: NSObject {

    static let baseURL = "http://api.themoviedb.org/3/"
    
    static let discover = baseURL + "discover/movie?api_key=acea91d2bff1c53e6604e4985b6989e2&page=%d"
    
    static let posterBaseURL = "https://image.tmdb.org/t/p/w500/"
}
