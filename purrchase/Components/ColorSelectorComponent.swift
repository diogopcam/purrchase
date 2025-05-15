//
//  ColorSlectoComponent.swift
//  purrchase
//
//  Created by Richard Fagundes Rodrigues on 14/05/25.
//

import UIKit

class ColorSelector: UIView {
    
    private let colorNames: [UIColor] = [.circle1, .circle2, .circle3, .circle4, .circle5, .circle6]
    
    lazy var namedLabel: UILabel = {
        let label = UILabel()
        label.text = "Colors"
        label.font = UIFont(name: "Poppins-Regular", size: 17)
        
        return label
    }()
    
    // TODO: Ajustar lógica que printa círculos na tela.
    lazy var coloredCircle: UIView = {
        let circle = UIView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.layer.cornerRadius = 30
        circle.layer.borderWidth = 2
        circle.layer.borderColor = UIColor.black.cgColor
        circle.backgroundColor = .circle1
        
        return circle
    }()

    lazy var stackColorSelector: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [namedLabel, coloredCircle])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.backgroundColor = .primary
        stackView.spacing = 8
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            stackColorSelector.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    
}

