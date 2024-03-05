//
//  CategoryListViewController.swift
//  Pizza
//
//  Created by Alexey Ivanov on 5/3/24.
//

import UIKit

final class CategoryListViewController: UIViewController {
    let service: StorageServiceProtocol = StorageService()
    
    var categories: [ProductCategory] = [ProductCategory]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)
//        layout.itemSize = CGSize(width: view.frame.width, height: 90)
        layout.estimatedItemSize = CGSize(width: view.frame.width, height: 90)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
        view.dataSource = self
        view.delegate = self
        let refreshControl = UIRefreshControl(
            frame: .zero,
            primaryAction: UIAction(handler: { [weak self] _ in
                self?.fetchData()
            })
        )
        view.refreshControl = refreshControl
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        fetchData()
    }
    
    func fetchData() {
        collectionView.refreshControl?.beginRefreshing()
        service.getCategories { [weak self] result in
            guard let self = self else { return }
            self.collectionView.refreshControl?.endRefreshing()
            
            switch result {
            case .success(let categories):
                self.categories = categories
                
            case .failure(let error):
                showError(error)
            }
        }
    }
    
}

protocol ErrorAlertPresentable {
    func showError(_ error: Error)
}
extension UIViewController: ErrorAlertPresentable {
    func showError(_ error: Error) {
        let alert = UIAlertController.init(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension CategoryListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifier, for: indexPath)
        guard let cell = cell as? CategoryCell,
              let category = categories[safe: indexPath.row]
        else { 
            return UICollectionViewCell()
        }
        cell.update(category: category)
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let vc = segue.destination as? ProductListViewController,
            let category = sender as? ProductCategory
        else { return }
        vc.category = category
    }
}
extension CategoryListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let category = categories[safe: indexPath.row] else {return}
        performSegue(withIdentifier: "toProductList", sender: category)
    }
}
