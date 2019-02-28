//
//  NetworkManager.swift
//  Instabug_Task
//
//  Created by Islam Soliman on 2/25/19.
//  Copyright © 2019 Islam Soliman. All rights reserved.
//

import UIKit

class NetworkManager {
    
    private let unknownErrorMsg = "Unknown error has occured"

    func getModel<T: Decodable>(of url: String, success: @escaping (T) -> Void, failure: @escaping (String) -> Void, finished: @escaping () -> Void) {

        
        
        var request : URLRequest = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in

            DispatchQueue.main.async { finished() }
            
            guard error == nil else {
                DispatchQueue.main.async { failure(error!.localizedDescription) }
                return
            }
            
            guard let data = data else {
                
                DispatchQueue.main.async { failure(error!.localizedDescription) }
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                
                if let errorResponse = try? JSONDecoder().decode(ResponseError.self, from: data) {
                    
                    DispatchQueue.main.async { failure(errorResponse.statusMsg ?? self.unknownErrorMsg) }
                    return
                    
                }
            }
            
            
            guard let model = try? JSONDecoder().decode(T.self, from: data) else {
                DispatchQueue.main.async { failure(self.unknownErrorMsg) }
                return
            }
            
            DispatchQueue.main.async {
                
                success(model)
            }
            
        }).resume()
        
    }
    
    static func downloadImage(from url: URL, success: @escaping (Data) -> Void, failure: @escaping () -> ()) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else {
                failure()
                return
            }
            success(data)
            
        }.resume()
    }
    
}
