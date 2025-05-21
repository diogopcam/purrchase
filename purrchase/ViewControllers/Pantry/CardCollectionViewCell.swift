//
//  CardCollectionViewCell.swift
//  UIKitChallenge-CollectionView
//
//  Created by Igor Vicente on 13/05/25.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    // MARK: Components
    lazy var productImage: UIImageView = {  // Changed from private to internal
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "photo")
        imageView.backgroundColor = .backgroundYellow
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 24.0
        imageView.isUserInteractionEnabled = true  // Enable user interaction
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
    var imageTapAction: (() -> Void)?  // Closure for tap action
    
    // MARK: Functions
    func configure(title: String, pImage: UIImage? = nil, onImageTap: (() -> Void)? = nil) {
        productName.text = title
        productImage.image = pImage
        self.imageTapAction = onImageTap
    }
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        contentView.layer.cornerRadius = 24.0
        contentView.clipsToBounds = true
        setupImageTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        productImage.addGestureRecognizer(tapGesture)
    }
    
    @objc private func imageTapped() {
        imageTapAction?()  // Execute the closure when image is tapped
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
        ])
    }
}
