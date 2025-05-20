//
//  CardCollectionViewCell.swift
//  UIKitChallenge-CollectionView
//
//  Created by Igor Vicente on 13/05/25.

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    // MARK: Components
    private lazy var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "photo")
        imageView.backgroundColor = .backgroundYellow
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 24.0
        imageView.clipsToBounds = true // Adicionado
        return imageView
    }()
    
    private lazy var productName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Medium", size: 15)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: Properties
    static let identifier: String = "cardCollectionCell"
    
    // MARK: Functions
    func configure(title: String, pImage: UIImage? = nil) {
        productName.text = title
        productImage.image = pImage
    }
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        contentView.layer.cornerRadius = 24.0
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardCollectionViewCell: ViewCodeProtocol {
    
    func addSubViews() {
        contentView.addSubview(productImage)
        contentView.addSubview(productName)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            productImage.heightAnchor.constraint(equalToConstant: 70), // altura controlada
            
            productName.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 4),
            productName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            productName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            productName.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -4)
        ])
    }
}
