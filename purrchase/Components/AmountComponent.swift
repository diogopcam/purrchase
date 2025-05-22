//
//  Amout.swift
//  purrchase
//
//  Created by Bernardo Garcia Fensterseifer on 15/05/25.
//

import UIKit

class AmountComponent: UIControl {
    
    // MARK: - Properties
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.text = "Amount"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.text = "\(value)"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(increment), for: .touchUpInside)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.addTarget(self, action: #selector(decrement), for: .touchUpInside)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var separatorLabel1: UILabel = {
        let label = UILabel()
        label.text = "  |"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var separatorLabel2: UILabel = {
        let label = UILabel()
        label.text = "|  "
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var value: Int = 1 {
        didSet {
            valueLabel.text = "\(value)"
            updateButtonStates()
        }
    }
    
    var minimumValue: Int = 1
    var maximumValue: Int = 10
    
    var name: String? {
        didSet {
            textLabel.text = name
        }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // MARK: - Setup
    private func setupViews() {
        backgroundColor = .backgroundPrimaria
        layer.cornerRadius = 17
        layer.borderWidth = 0
        layer.borderColor = UIColor.backgroundPrimaria.cgColor
        
        // Quantity stack (minus, value, plus)
        let quantityStack = UIStackView(arrangedSubviews: [minusButton, separatorLabel1, valueLabel, separatorLabel2, plusButton])
        quantityStack.axis = .horizontal
        quantityStack.distribution = .fill
        quantityStack.alignment = .center
        quantityStack.spacing = 5
        
        let borderStack = UIView()
        borderStack.backgroundColor = .clear
        borderStack.addSubview(quantityStack)
        borderStack.layer.cornerRadius = 8
        borderStack.layer.borderWidth = 1
        borderStack.layer.borderColor = UIColor.systemGray.cgColor  // Changed to borderStack.layer
        quantityStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Main stack (textLabel + quantityStack)
        let mainStack = UIStackView(arrangedSubviews: [textLabel, borderStack])
        mainStack.axis = .horizontal
        mainStack.distribution = .equalSpacing
        mainStack.alignment = .center
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStack)
        
        // Constraints
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            borderStack.topAnchor.constraint(equalTo: quantityStack.topAnchor, constant: -5),
            borderStack.bottomAnchor.constraint(equalTo: quantityStack.bottomAnchor, constant: 5),
            borderStack.leadingAnchor.constraint(equalTo: quantityStack.leadingAnchor, constant: -8),
            borderStack.trailingAnchor.constraint(equalTo: quantityStack.trailingAnchor, constant: 8),
            
            minusButton.widthAnchor.constraint(equalToConstant: 24),
            minusButton.heightAnchor.constraint(equalToConstant: 24),
            plusButton.widthAnchor.constraint(equalToConstant: 24),
            plusButton.heightAnchor.constraint(equalToConstant: 24),
            valueLabel.widthAnchor.constraint(equalToConstant: 35)
        ])
        
        updateButtonStates()
    }
    
    // MARK: - Button Actions
    @objc private func increment() {
        guard value < maximumValue else { return }
        value += 1
        sendActions(for: .valueChanged)
    }
    
    @objc private func decrement() {
        guard value > minimumValue else { return }
        value -= 1
        sendActions(for: .valueChanged)
    }
    
    private func updateButtonStates() {
        minusButton.isEnabled = value > minimumValue
        plusButton.isEnabled = value < maximumValue
        
        minusButton.tintColor = value == minimumValue ? .systemGray : .label
        plusButton.tintColor = value == maximumValue ? .systemGray : .label
    }
    
    // MARK: - Intrinsic Content Size
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 44)
    }
}
