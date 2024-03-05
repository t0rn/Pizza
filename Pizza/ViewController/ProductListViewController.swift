//
//  ListViewController.swift
//  Pizza
//
//  Created by Alexey Ivanov on 4/3/23.
//

import UIKit
import Kingfisher

class ProductListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let storage: StorageServiceProtocol = StorageService()
    
    var productList = [ProductModel]()
    
    var category: ProductCategory?

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        updateWith(category: category)
    }
    
    func updateWith(category: ProductCategory?) {
        guard let category = category else {
            productList = [ProductModel]()
            collectionView.reloadData()
            return
        }
        fetchProducts(in: category)
    }
    
    func fetchProducts(in category: ProductCategory) {
        storage.getProductsFor(category: category) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let products):
                self.productList = products
                
            case .failure(let error):
                self.showError(error)
            }
            
            self.collectionView.reloadData()
        }
    }
    
    //MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PizzaCollectionViewCell", for: indexPath)
        
        if
            let productCell = cell as? PizzaCollectionViewCell,
            let product = productList[safe: indexPath.row] {
            productCell.titleLabel.text = product.name
            productCell.descriptionLabel.text = product.description
            let url = URL(string: "https://www.foodandwine.com/thmb/BK0P-VpOvPowtz-okmiaS4kTqvI=/750x0/filters:no_upscale():max_bytes(150000):strip_icc()/classic-cheese-pizza-FT-RECIPE0422-31a2c938fc2546c9a07b7011658cfd05.jpg")!
            productCell.imageView.kf.setImage(with: Source.network(url))
        }
        
        return cell
    }
    
    //MARK: UICollectionViewDelegate
    
}
