//
//  ListViewController.swift
//  Pizza
//
//  Created by Alexey Ivanov on 4/3/23.
//

import UIKit
import Kingfisher

class ListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let fetcher = ConfigFetcher()
    
    var config: AppConfig? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchData()
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.itemSize = CGSize(width: collectionView.bounds.width, height: 20)
        }
        
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
//            print(jsonString)
        }
    }
    func fetchData() {
        fetcher.fetchConfig { [weak self] (error, config) -> Void in
//            guard let self = self else {return}
            if let error = error {
                //TODO: SHOW error alert
                return
            }
            self?.config = config
        }
    }

    //MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        config?.pizzaList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PizzaCollectionViewCell", for: indexPath)
        
        if
            let pizzaCell = cell as? PizzaCollectionViewCell,
            let pizza = config?.pizzaList[indexPath.row] {
            pizzaCell.titleLabel.text = pizza.name
            pizzaCell.descriptionLabel.text = pizza.description
            let url = URL(string: "https://www.foodandwine.com/thmb/BK0P-VpOvPowtz-okmiaS4kTqvI=/750x0/filters:no_upscale():max_bytes(150000):strip_icc()/classic-cheese-pizza-FT-RECIPE0422-31a2c938fc2546c9a07b7011658cfd05.jpg")!
            pizzaCell.imageView.kf.setImage(with: Source.network(url))
        }
        
        return cell
    }
    
    //MARK: UICollectionViewDelegate
    
}
