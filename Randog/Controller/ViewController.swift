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
        
        DogAPI.requestRandomImage(completionHandler: handleRandomImageResponse(dogImage:error:))
    }
    
    func handleRandomImageResponse(dogImage: DogImage?, error: Error?) {
        guard let imageUrl = URL(string: dogImage?.message ?? "") else {
             return
         }
         
         DogAPI.requestImageFile(url: imageUrl, completionHandler: self.handleImageFileResponse(image:error:))
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}
