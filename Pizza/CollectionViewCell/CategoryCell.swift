//
//  CategoryCell.swift
//  Pizza
//
//  Created by Alexey Ivanov on 5/3/24.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    static var reuseIdentifier: String {
        String(describing: type(of: self))
    }
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
        
    func commonInit() {
        contentView.backgroundColor = .white
        let vStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.axis = .vertical
        vStackView.spacing = 8
        vStackView.distribution = .fill
        vStackView.alignment = .fill
        contentView.addSubview(vStackView)
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: topAnchor),
            vStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            vStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func update(category: ProductCategory) {
        titleLabel.text = category.name
        descriptionLabel.text = category.description
    }
}
