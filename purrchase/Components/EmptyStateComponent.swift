//
//  EmptyStateComponent.swift
//  purrchase
//
//  Created by Maria Santellano on 16/05/25.
//

import UIKit

class EmptyStateComponent: UIView {

    //MARK: Cat icon
    private lazy var catIcon: ImageCatComponent = {
        var catIcon = ImageCatComponent()
        catIcon.translatesAutoresizingMaskIntoConstraints = false
        return catIcon
    }()
    
    //MARK: Stack
    private lazy var stack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [catIcon])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 42
        stack.isUserInteractionEnabled = true

        
        return stack
    }()

    
    //MARK: Properties
    var image: UIImage? {
        didSet {
            catIcon.image = image
        }
    }
    
    
//    
//    var bgCard: UIColor? {
//        didSet {
//            listCard.backgroundColor = bgCard
//        }
//    }
    
    var listCardTapped: () -> Void = {}

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped() {
        listCardTapped()
    }
    
}

//MARK: ViewCodeProtocol
extension EmptyStateComponent: ViewCodeProtocol {
    func addSubViews() {
        addSubview(stack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
