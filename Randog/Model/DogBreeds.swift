//
//  DogBreeds.swift
//  Randog
//
//  Created by Márcio Oliveira on 8/21/20.
//  Copyright © 2020 Márcio Oliveira. All rights reserved.
//

import Foundation

struct DogBreeds: Codable {
    let status: String
    let message: [String: [String]]
}
