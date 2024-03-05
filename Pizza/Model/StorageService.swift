//
//  StorageService.swift
//  Pizza
//
//  Created by Alexey Ivanov on 5/3/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class StorageService: StorageServiceProtocol {
    let store: Firestore

    init(store: Firestore = Firestore.firestore()) {
        self.store = store
    }
    
    func getCategories(completion: @escaping (Result<[ProductCategory], Error>) -> Void) {
        store
            .collection(ProductCategory.collectionPath)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                do {
                    let objects = try snapshot?
                        .documents
                        .compactMap({ snapshot -> ProductCategory? in
                            try snapshot.data(as: ProductCategory.self)
                        })
                    let result = objects ?? [ProductCategory]()
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
    }
    func getProductsFor(category: ProductCategory, completion: @escaping (Result<[ProductModel],Error>) -> Void) {
        guard let products = category.productIds else {
            completion(Result.success([ProductModel]()))
            
            return
        }
        
        store
            .collectionGroup(ProductModel.collectionPath)
            .whereField(FieldPath.documentID(), in: products)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                do {
                    let objects = try snapshot?
                        .documents
                        .compactMap({ snapshot -> ProductModel? in
                            try snapshot.data(as: ProductModel.self)
                        })
                    let result = objects ?? [ProductModel]()
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
    }
    
    func getProducts(completion: @escaping (Result<[ProductModel], Error>) -> Void) {
        store
            .collection(ProductModel.collectionPath)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                do {
                    let objects = try snapshot?
                        .documents
                        .compactMap({ snapshot -> ProductModel? in
                            try snapshot.data(as: ProductModel.self)
                        })
                    let result = objects ?? [ProductModel]()
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
    }
}

extension ProductCategory {
    static let collectionPath = "category"
}
extension ProductModel {
    static let collectionPath = "products"
}

protocol StorageServiceProtocol {
    func getCategories(completion: @escaping (Result<[ProductCategory], Error>) -> Void)
    func getProducts(completion: @escaping (Result<[ProductModel], Error>) -> Void)
    func getProductsFor(category: ProductCategory, completion: @escaping (Result<[ProductModel],Error>) -> Void)
}




