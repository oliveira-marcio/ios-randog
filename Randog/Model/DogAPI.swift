//
//  DogAPI.swift
//  Randog
//
//  Created by Márcio Oliveira on 8/20/20.
//  Copyright © 2020 Márcio Oliveira. All rights reserved.
//

import Foundation
import UIKit

class DogAPI {
    enum Endpoint: String {
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        
        var url: URL {
            return URL(string: self.rawValue)!
        }
    }
    
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
        
            let downloadedImage = UIImage(data: data)
            completionHandler(downloadedImage, nil)
        }
        task.resume()
    }
}
