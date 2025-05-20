//
//  Image+Text.swift
//  purrchase
//
//  Created by Richard Fagundes Rodrigues on 16/05/25.
//

import UIKit

class ProductImageComponent: UIView {
    
    lazy var imageView: UIImageView  = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.heightAnchor.constraint(equalToConstant: 215).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 215).isActive = true
        return icon
    }()


    lazy var textLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Poppins-Medium", size: 40)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var stackView: UIStackView = {
       var view = UIStackView(arrangedSubviews: [imageView, textLabel])
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        // MARK: TALVEZ PRECISE ALTERAR
        //view.distribution = .fill
        view.spacing = 24
        return view
    }()
    
    var name: String? {
        get {
            return textLabel.text
        }
        set {
            textLabel.text = newValue
        }
    }
    
    var image : UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
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

extension ProductImageComponent: ViewCodeProtocol {
    func addSubViews() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    
}
