//
//  ImageDownloader.swift
//  Instabug_Task
//
//  Created by Islam Soliman on 2/25/19.
//  Copyright © 2019 Islam Soliman. All rights reserved.
//

import UIKit

class ImageDownloader {

    private static let imageCache = NSCache<AnyObject, AnyObject>()
    
    static func getImage(at path: String, success: @escaping (UIImage) -> Void, setPlaceHolder: @escaping () -> Void) {
        
        if let cashedImage = imageCache.object(forKey: path as AnyObject) as? UIImage {
            
            success(cashedImage)
            return
        }
        
        guard let url = URL(string: path) else {
            
            setPlaceHolder()
            return
        }
        
        downloadImage(at: url, success: success, setPlaceHolder: setPlaceHolder)
    }
    
    static func downloadImage(at url: URL, success: @escaping (UIImage) -> Void, setPlaceHolder: @escaping () -> Void) {
        
        NetworkManager.downloadImage(from: url, success: { (data) in
            
            DispatchQueue.main.async {
                
                if let image = UIImage(data: data) {
                    
                    imageCache.setObject(image, forKey: url.absoluteString as AnyObject)
                    success(image)
                } else {
                    
                    setPlaceHolder()
                }
                
            }
            
        }) {
            
            DispatchQueue.main.async { setPlaceHolder() }
        }
        
    }
    
}
