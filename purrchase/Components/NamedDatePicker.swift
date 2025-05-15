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
        label.font = UIFont(name: "SFProRounded-Semibold", size: 17)
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        return datePicker
    }()

    private lazy var stack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [nameLabel, datePicker])
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
