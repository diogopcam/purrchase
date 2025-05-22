//
//  NavBarComponent.swift
//  purrchase
//
//  Created by Maria Santellano on 14/05/25.
//

import UIKit

class NavBarComponent: UIView {

    //MARK: Cancel Button
    private lazy var cancelButton: UIButton = {
        var button = UIButton()
        button.setTitleColor(.textAndIcons, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 17)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: Add List label
    lazy var addListLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Poppins-SemiBold", size: 17)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    //MARK: Done Button
    lazy var doneButton: UIButton = {
        var button = UIButton()
        button.setTitleColor(.textAndIcons, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 17)
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: Header Stack
    lazy var headerStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [cancelButton, addListLabel, doneButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalCentering
        
        return stack
    }()
    
    //MARK: Separator Line
    lazy var separator: UIView = {
        var separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .separator
        return separator
    }()
    
    //MARK: Properties
    
    var firstButtonTitle: String? {
        didSet {
            cancelButton.setTitle(firstButtonTitle, for: .normal)
        }
    }
    
    var title: String? {
        didSet {
            addListLabel.text = title
        }
    }
    
    var secondButtonTitle: String? {
        didSet {
            doneButton.setTitle(secondButtonTitle, for: .normal)
        }
    }
    
    var cancelButtonAction: () -> Void = {}
    var doneButtonAction: () -> Void = {}
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    @objc func cancelButtonTapped() {
        cancelButtonAction()
    }
    
    @objc func doneButtonTapped() {
        doneButtonAction()
    }
}


extension NavBarComponent: ViewCodeProtocol {
    func addSubViews() {
        addSubview(headerStack)
        addSubview(separator)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: self.topAnchor),
            headerStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            headerStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            separator.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 11),
            separator.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.25),
        ])
    }
}
