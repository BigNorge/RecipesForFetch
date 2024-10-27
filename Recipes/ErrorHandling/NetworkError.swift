//
//  CustomError.swift
//  Recipes
//
//  Created by Arne Moen on 10/24/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case dataDecoding
}
