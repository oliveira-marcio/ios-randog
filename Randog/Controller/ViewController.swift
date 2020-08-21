//
//  ViewController.swift
//  Randog
//
//  Created by Márcio Oliveira on 8/20/20.
//  Copyright © 2020 Márcio Oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let breeds: [String] = ["greyhound", "poodle", "pug"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         DogAPI.requestRandomImage(completionHandler: handleRandomImageResponse(dogImage:error:))
    }
}
