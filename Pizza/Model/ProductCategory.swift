//
//  ProductCategory.swift
//  Pizza
//
//  Created by Alexey Ivanov on 5/3/24.
//

import Foundation
import FirebaseFirestore

struct ProductCategory: Codable {
    let name: String?
    let description: String?
    let categoryIds: [String]?
    let productIds: [DocumentReference]?
}
