//
//  ColorSlectoComponent.swift
//  purrchase
//
//  Created by Richard Fagundes Rodrigues on 14/05/25.
//

import UIKit

class ColorSelector: UIView {
    
    private let colorNames: [UIColor] = [
        .circle1, .circle2, .circle3,
        .circle4, .circle5, .circle6
    ]
    
    lazy var namedLabel: UILabel = {
        let label = UILabel()
        label.text = "Colors"
        label.font = UIFont(name: "Poppins-Regular", size: 17)
        
        return label
    }()
    
    private lazy var circleStack: UIStackView = {
            let circles = colorNames.map { createCircle(color: $0) }
            let stackView = UIStackView(arrangedSubviews: circles)
            stackView.spacing = 9
        
            return stackView
        }()

    lazy var stackColorSelector: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [namedLabel, circleStack])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.layer.cornerRadius = 12
        stackView.backgroundColor = UIColor.primary.withAlphaComponent(0.5)
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 16, right: 16)
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createCircle(color: UIColor) -> UIView {
            let circle = UIView()
            circle.backgroundColor = color
            circle.layer.cornerRadius = 21
            circle.layer.borderWidth = 1
            circle.layer.borderColor = UIColor.black.cgColor
            
            NSLayoutConstraint.activate([
                circle.widthAnchor.constraint(equalToConstant: 42),
                circle.heightAnchor.constraint(equalToConstant: 42)
            ])
            
            return circle
        }
}

extension ColorSelector: ViewCodeProtocol {
    func addSubViews() {
        addSubview(stackColorSelector)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackColorSelector.topAnchor.constraint(equalTo: self.topAnchor),
            stackColorSelector.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackColorSelector.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackColorSelector.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    
}

