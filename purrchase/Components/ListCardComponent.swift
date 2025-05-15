//
//  ListCard.swift
//  purrchase
//
//  Created by Maria Santellano on 13/05/25.
//

import UIKit

class ListCard: UIView {
    
    // MARK: "Lista Padrão" description
    private lazy var descriptionTitleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Medium", size: 17)
        label.textColor = .textAndIcons
        
        return label
    }()

    //MARK: List Title
    private lazy var titleLabel: UILabel = {
        var title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .black
        title.font = UIFont(name: "Poppins-Medium", size: 36)
        
        return  title
    }()
    
    //MARK: Stack description and Title
    private lazy var textsStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [descriptionTitleLabel, titleLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 0
        
        return stack
    }()
    
    //MARK: List Clipboard Icon
    private lazy var icon: UIImageView = {
        var icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.image = UIImage(systemName: "list.bullet.clipboard")
        icon.tintColor = .textAndIcons
              
        return icon
    }()
    
    //MARK: Stack Texts and Icon
    private lazy var iconAndTextStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [textsStack, icon])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 120
        stack.layer.cornerRadius = 12
        stack.backgroundColor = .circle4
        
        return stack
    }()
    
    //MARK: Properties
    var descriptionText: String? {
        didSet {
            descriptionTitleLabel.text = descriptionText
        }
    }
    
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    var backgroundStack: UIColor? {
        didSet {
            iconAndTextStack.backgroundColor = backgroundStack
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

extension ListCard: ViewCodeProtocol {
    func addSubViews() {
        addSubview(iconAndTextStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            
            iconAndTextStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            iconAndTextStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            iconAndTextStack.topAnchor.constraint(equalTo: self.topAnchor),
            iconAndTextStack.heightAnchor.constraint(equalToConstant: 104),
            
            textsStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            icon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            icon.heightAnchor.constraint(equalToConstant: 43),
            icon.widthAnchor.constraint(equalToConstant: 40),
            
            textsStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            textsStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 12)
        ])
    }
}
