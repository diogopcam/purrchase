//
//  CustomCenteredCell.swift
//  purrchase
//
//  Created by Diogo Camargo on 15/05/25.
//
//

import UIKit

class CustomCenteredCell: UITableViewCell {
    
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .softGreen
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iv.widthAnchor.constraint(equalToConstant: 24),
            iv.heightAnchor.constraint(equalToConstant: 24)
        ])
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        label.textColor = .softGreen
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 6
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isUserInteractionEnabled = true
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .backgroundWhite
        contentView.backgroundColor = .backgroundWhite
        selectionStyle = .default
        
        hStack.addArrangedSubview(iconImageView)
        hStack.addArrangedSubview(titleLabel)
        contentView.addSubview(hStack)
        
        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 12),
            hStack.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -12),
           hStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
           hStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
           hStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
