//
//  CardCollectionViewCell.swift
//  UIKitChallenge-CollectionView
//
//  Created by Igor Vicente on 13/05/25.

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
    
    private lazy var productNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Light", size: 15)
        label.textColor = .labelSecondary
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: Properties
    static let identifier: String = "cardCollectionCell"
    var imageTapAction: (() -> Void)?  // Closure for tap action
    
    // MARK: Functions
    func configure(title: String, pImage: UIImage? = nil, number: Int? = nil, onImageTap: (() -> Void)? = nil) {
        productName.text = title
        productImage.image = pImage
        self.imageTapAction = onImageTap

        if let number = number {
            productNumber.text = String(number)
            productNumber.isHidden = false
        } else {
            productNumber.isHidden = true
        }
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
        contentView.addSubview(productNumber)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Imagem
            productImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productImage.heightAnchor.constraint(equalToConstant: 70),
            productImage.widthAnchor.constraint(equalToConstant: 10),

            // Nome do produto
            productName.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 4),
            productName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            productName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),

            // Número do produto
            productNumber.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 0),
            productNumber.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            productNumber.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
        ])
    }
}
