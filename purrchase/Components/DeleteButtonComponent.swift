//
//  DeleteButton.swift
//  purrchase
//
//  Created by Richard Fagundes Rodrigues on 16/05/25.
//

import UIKit

class DeleteButtonComponent: UIView {
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Medium", size: 24)
        label.text = "Delete"
        label.textColor = .systemRed
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    lazy var iconview: UIImageView = {
        var icon = UIImageView()
        icon.image = UIImage(systemName: "trash")
        icon.tintColor = .systemRed
        return icon
    }()
    
    private lazy var deleteStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [textLabel, iconview])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(deleteStack)
        
        NSLayoutConstraint.activate([
            deleteStack.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            deleteStack.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        
        button.layer.cornerRadius = 24
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemRed.cgColor
        
        //Adicionar lógica
        //button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [deleteButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 0
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DeleteButtonComponent: ViewCodeProtocol {
    func addSubViews() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            iconview.widthAnchor.constraint(equalToConstant: 27),
            iconview.heightAnchor.constraint(equalToConstant: 24),
            
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
    
}
