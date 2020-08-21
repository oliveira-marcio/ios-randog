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
    enum Endpoint {
        case randomImageFromAllDogsCollection
        case randomImageFromBreed(String)
        case listAllBreeds
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageFromBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
    }
    
    class func requestRandomImage(breed: String,  completionHandler: @escaping (DogImage?, Error?) -> Void) {
        let randomImageEndpoint = DogAPI.Endpoint.randomImageFromBreed(breed).url
        
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) {
            (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let imageData = try decoder.decode(DogImage.self, from: data)
                completionHandler(imageData, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
        
        task.resume()
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
    
    class func requestBreedsList(completionHandler: @escaping ([String], Error?) -> Void) {
        let randomImageEndpoint = DogAPI.Endpoint.listAllBreeds.url
        
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) {
            (data, response, error) in
            guard let data = data else {
                completionHandler([], error)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let breedsData = try decoder.decode(DogBreeds.self, from: data)
                let breeds = breedsData.message.keys.map({$0})
                completionHandler(breeds, nil)
            } catch {
                completionHandler([], error)
            }
        }
        
        task.resume()
    }
}
