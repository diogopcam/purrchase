//
//  NamedDatePicker.swift
//  purrchase
//
//  Created by Bernardo Fensterseifer on 15/05/25.
//

import UIKit

class NamedDatePicker: UIView {
    // MARK: Subviews
    private lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.text = "Expirations Date"
        label.font = UIFont(name: "Poppins-Medium", size: 17)
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.tintColor = .textAndIcons
        return datePicker
    }()

    lazy var stack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, datePicker])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        stackView.backgroundColor = UIColor.primary.withAlphaComponent(0.5)
        stackView.layer.cornerRadius = 12
        stackView.layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 5)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    // MARK: Properties
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    var date: Date {
        get {
            datePicker.date
        }
        set {
            datePicker.date = newValue
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

extension NamedDatePicker: ViewCodeProtocol {
    
    func addSubViews() {
        addSubview(stack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
