//
//  StyleNavBarComponent.swift
//  Purrchase
//
//  Created by Bernardo Garcia Fensterseifer on 22/05/25.
//

import UIKit

class StyleNavBarComponent: UIView {
    
    lazy var backGroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .backgroundPrimaria
        return view
    }()
    
    //MARK: Add List label
    lazy var addListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-SemiBold", size: 23)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var addListSubtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Medium", size: 16)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var imageSubtitle: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "timer")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        return imageView
    }()
    
    lazy var stackSubtitle: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [addListSubtitleLabel, imageSubtitle])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.spacing = 5
        stack.alignment = .center
        stack.axis = .horizontal
        return stack
    }()
    
    //MARK: Header Stack
    lazy var headerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [addListLabel, stackSubtitle])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.alignment = .center
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    //MARK: Separator Line
    lazy var separator: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .separator
        return separator
    }()
    
    //MARK: Properties
    var title: String? {
        didSet {
            addListLabel.text = title
        }
    }
    
    var subtitle: String? {
        didSet {
            addListSubtitleLabel.text = subtitle
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

extension StyleNavBarComponent: ViewCodeProtocol {
    
    func addSubViews() {
        addSubview(backGroundView)
        addSubview(headerStack)
        addSubview(separator)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backGroundView.topAnchor.constraint(equalTo: topAnchor, constant: -16),
            backGroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backGroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backGroundView.bottomAnchor.constraint(equalTo: separator.topAnchor),
            
            headerStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            headerStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            separator.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 11),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
}
