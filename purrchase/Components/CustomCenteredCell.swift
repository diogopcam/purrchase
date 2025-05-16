//
//  CustomCenteredCell.swift
//  purrchase
//
//  Created by Diogo Camargo on 15/05/25.
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
        label.textAlignment = .center
        return label
    }()
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        selectionStyle = .none
        
        hStack.addArrangedSubview(iconImageView)
        hStack.addArrangedSubview(titleLabel)
        contentView.addSubview(hStack)
        
        NSLayoutConstraint.activate([
            hStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            hStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
