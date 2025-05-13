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
        return label
    }()
    
    lazy var greenPlusIcon : UIImageView  = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(named: "GreenPlus-Icon")
        icon.heightAnchor.constraint(equalToConstant: 18).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 19).isActive = true
        return icon
    }()
    
    private lazy var textStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [nameLabel, greenPlusIcon])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 10
        stack.backgroundColor = UIColor(named: "Primaria")
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
        
        /// aqui fica a ação que o botão irá ativar (implementar de acordo futuramente)
        //  button.addTarget(self, action: #selector(handleAddList), for: .touchUpInside)
        
        button.backgroundColor = UIColor(named: "Primaria")
        button.layer.cornerRadius = 17
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
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
            return greenPlusIcon.image
        }
        set {
            greenPlusIcon.image = newValue
        }
    }
    
    var button: UIButton {
        return addListButton
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
            stack.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
}
