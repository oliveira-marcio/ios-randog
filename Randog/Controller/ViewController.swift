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
        
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) {
            (data, response, error) in
            guard let data = data else {
                print("No data returned or there was an error.")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let url = json["message"] as! String
                print(url)
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
