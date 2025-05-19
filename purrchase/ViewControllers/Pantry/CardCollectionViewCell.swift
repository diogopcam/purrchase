//
//  CardCollectionViewCell.swift
//  UIKitChallenge-CollectionView
//
//  Created by Igor Vicente on 13/05/25.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    // MARK: Components
    private lazy var productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .backgroundYellow
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 24.0
        return imageView
    }()
    
    private lazy var productName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Medium", size: 15)
        label.textColor = .label
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
            productImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            productImage.topAnchor.constraint(equalTo: self.topAnchor),
            
            productName.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 2),
            productName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            //productName.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
