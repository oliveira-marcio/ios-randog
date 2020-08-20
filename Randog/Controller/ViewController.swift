//
//  ViewController.swift
//  Randog
//
//  Created by Márcio Oliveira on 8/20/20.
//  Copyright © 2020 Márcio Oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let randomImageEndpoint = DogAPI.Endpoint.randomImageFromAllDogsCollection.url
        
        let apiTask = URLSession.shared.dataTask(with: randomImageEndpoint) {
            (data, response, error) in
            guard let data = data else {
                print("No data returned or there was an error.")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let imageData = try decoder.decode(DogImage.self, from: data)
                
                guard let imageUrl = URL(string: imageData.message) else {
                    print("Error creating image URL.")
                    return
                }
                
                let imageTask = URLSession.shared.dataTask(with: imageUrl) {
                    (data, response, error) in
                    guard let data = data else {
                        print("No data returned or there was an error.")
                        return
                    }
                    
                    let downloadedImage = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.imageView.image = downloadedImage
                    }
                }
                
                imageTask.resume()
                
            } catch {
                print(error)
            }
        }
        
        apiTask.resume()
    }
}
