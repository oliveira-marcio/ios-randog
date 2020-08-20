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
                
                DogAPI.requestImageFile(url: imageUrl, completionHandler: self.handleImageFileResponse(image:error:))
                
            } catch {
                print(error)
            }
        }
        
        apiTask.resume()
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}
