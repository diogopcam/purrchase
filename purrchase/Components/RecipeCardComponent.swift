//
//  RecipeInspirationComponent.swift
//  purrchase
//
//  Created by Maria Santellano on 21/05/25.
//
import UIKit

class RecipeCardComponent: UIView {
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = .cookieInspiration
        
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        var name =  UILabel()
        name.font = UIFont(name: "Poppins-Medium", size: 17)
        
        return name
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, nameLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .backgroundSecondary
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.layer.cornerRadius = 16
        stackView.layoutMargins = .init(top: 8, left: 8, bottom: 8, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    
    
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }

    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecipeCardComponent: ViewCodeProtocol {
    func addSubViews() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            stackView.heightAnchor.constraint(equalToConstant: 138),
        ])
    }
}

