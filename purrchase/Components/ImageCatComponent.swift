//
//  ImageCatComponent.swift
//  purrchase
//
//  Created by Bernardo Garcia Fensterseifer on 13/05/25.
//

import UIKit

class ImageCatComponent: UIView {
    
    // MARK: Subviews
    private lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Quicksand-SemiBold", size: 17)
        label.text = "Click on “Add List” to add a new list"
        label.textColor = .grayText
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        NSLayoutConstraint.activate([label.widthAnchor.constraint(equalToConstant: 215)]
        )
        return label
    }()
    
    lazy var catImage : UIImageView  = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(named: "Cat-Image")
        icon.heightAnchor.constraint(equalToConstant: 215).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 215).isActive = true
        return icon
    }()

    private lazy var stack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [catImage, nameLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 0
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()
    
    // MARK: Properties
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    var image: UIImage? {
        get {
            return catImage.image
        }
        set {
            catImage.image = newValue
        }
    }
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ImageCatComponent: ViewCodeProtocol {
    func addSubViews() {
        addSubview(stack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            /// deixei comentado pois acredito que talvez a designer queira que essa constraint mude dependendo do dispositivo (ex.: iPad)
            //  stack.heightAnchor.constraint(equalToConstant: 257)
        ])
    }
}
