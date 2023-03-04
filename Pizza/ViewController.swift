//
//  ViewController.swift
//  Pizza
//
//  Created by Alexey Ivanov on 4/3/23.
//

import UIKit

struct AppConfig: Codable {
    let pizzaList: [PizzaModel]
    
}

struct PizzaModel: Codable {
    let name: String
    let description: String
    let imageLink: String
}

class ListViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        
        
        let config = AppConfig(pizzaList: [
            PizzaModel(name: "Chiz bomba",
                       description: "",
                       imageLink: ""),
            PizzaModel(name: "Pepperoni",
                       description: "",
                       imageLink: ""),
            PizzaModel(name: "Margaritta",
                       description: "",
                       imageLink: ""),
            PizzaModel(name: "4 cheez",
                       description: "",
                       imageLink: "")
        ])
        if let jsonData = try? JSONEncoder().encode(config) {
            let jsonString = String(data: jsonData, encoding: .utf8)
            print(jsonString)
        }
        
        
    }

    //MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PizzaCollectionViewCell", for: indexPath)
        
        if let pizzaCell = cell as? PizzaCollectionViewCell {
//            pizzaCell.descriptionLabel =
        }
        
        return cell
    }
}


class OrderViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class HomeViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}


class PizzaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
}
