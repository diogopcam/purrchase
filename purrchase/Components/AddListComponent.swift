//
//  AddListComponent.swift
//  purrchase
//
//  Created by Bernardo Garcia Fensterseifer on 13/05/25.
//

import UIKit

class AddListComponent: UIView {
    
    // MARK: Subviews
    private lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Poppins-Medium", size: 24)
        label.text = "Add List"
//        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var plusIcon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false

        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)
        icon.image = UIImage(systemName: "plus", withConfiguration: config)
        icon.tintColor = .softGreen
        icon.heightAnchor.constraint(equalToConstant: 18).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 18).isActive = true
        return icon
    }()
    
    private lazy var textStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [nameLabel, plusIcon])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 10
        stack.backgroundColor = .primary
        stack.heightAnchor.constraint(equalToConstant: 42).isActive = true
        plusIcon.centerYAnchor.constraint(equalTo: stack.centerYAnchor).isActive = true
        stack.alignment = .center
        stack.isUserInteractionEnabled = false
        return stack
    }()
    
    lazy var addListButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(textStack)
        
        NSLayoutConstraint.activate([
            textStack.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            textStack.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        
        button.addTarget(self, action: #selector(addListButtonTapped), for: .touchUpInside)
        
        button.backgroundColor = .primary
        button.layer.cornerRadius = 17
        //button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        return button
    }()

    private lazy var stack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [addListButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 0
        return stack
    }()
    
    // MARK: Properties
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    var plusImage: UIImage? {
        get {
            return plusIcon.image
        }
        set {
            plusIcon.image = newValue
        }
    }
    
    var button: UIButton {
        return addListButton
    }
    
    var addListButtonAction: () -> Void = {}    
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addListButtonTapped() {
        addListButtonAction()
    }
    
}

extension AddListComponent: ViewCodeProtocol {
    func addSubViews() {
        addSubview(stack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.heightAnchor.constraint(equalToConstant: 56),
            
        ])
    }
    
}
