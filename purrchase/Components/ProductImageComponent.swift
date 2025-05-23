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
        icon.layer.cornerRadius = 24
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.heightAnchor.constraint(equalToConstant: 215).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 215).isActive = true
        icon.clipsToBounds = true
        icon.isUserInteractionEnabled = true
        icon.contentMode = .scaleAspectFill
        return icon
    }()

//    lazy var textLabel: UILabel = {
//        var label = UILabel()
//        label.font = UIFont(name: "Poppins-Medium", size: 40)
//        label.numberOfLines = 0
//        label.lineBreakMode = .byWordWrapping
//        label.textAlignment = .center
//        label.translatesAutoresizingMaskIntoConstraints = false
//        
//        return label
//    }()
    
    lazy var textLabel: UITextField = {
        let tf = UITextField()
        tf.font = UIFont(name: "Poppins-Medium", size: 40)
        tf.textAlignment = .center
        tf.borderStyle = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    
    lazy var stackView: UIStackView = {
       var view = UIStackView(arrangedSubviews: [imageView, textLabel])
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 10
        view.alignment = .center
        return view
    }()
    
    var onImageTap: (() -> Void)?
    
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func imageTapped() {
        onImageTap?()
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
    
    func setup() {
            addSubViews()
            setupConstraints()
        }
    
}


