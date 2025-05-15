//
//  ZoomSliderComponent.swift
//  purrchase
//
//  Created by Bernardo Garcia Fensterseifer on 15/05/25.
//

import UIKit

class ZoomSliderComponent: UIView {
    
    lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = UIFont(name: "Poppins-SemiBold", size: 13)
        textLabel.text = "ZOOM"
        textLabel.textColor = .textAndIcons
        textLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return textLabel
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0.5
        // Configure minus icon with proper sizing
        let minusImage = UIImage(systemName: "minus")?
                .withConfiguration(UIImage.SymbolConfiguration(pointSize: 14, weight: .bold))
                .withTintColor(.textAndIcons, renderingMode: .alwaysOriginal)
        slider.minimumValueImage = minusImage
            
        // Configure plus icon with proper sizing
        let plusImage = UIImage(systemName: "plus")?
                .withConfiguration(UIImage.SymbolConfiguration(pointSize: 14, weight: .bold))
                .withTintColor(.textAndIcons, renderingMode: .alwaysOriginal)
        slider.maximumValueImage = plusImage
        slider.minimumTrackTintColor = .textAndIcons
        slider.maximumTrackTintColor = .textAndIcons
        slider.isContinuous = true
        slider.minimumTrackTintColor = .textAndIcons
        slider.maximumTrackTintColor = .lightGray
        
        return slider
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textLabel, slider])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    var name: String? {
        didSet {
            textLabel.text = name
        }
    }
    
    override var backgroundColor: UIColor? {
        didSet {
            stackView.backgroundColor = backgroundColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ZoomSliderComponent: ViewCodeProtocol {
    func addSubViews() {
        addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            slider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            slider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
