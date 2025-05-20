//
//  CardCollectionViewCell.swift
//  purrchase
//
//  Created by Maria Santellano on 19/05/25.
//

import UIKit

class ListCardCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "listCardCollectionCell"
    
    // MARK: "Lista Padrão" description
    private lazy var descriptionTitleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Medium", size: 17)
        label.textColor = .textAndIcons
        
        return label
    }()
    
    //MARK: List Title
    private lazy var titleLabel: UILabel = {
        var title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = .black
        title.font = UIFont(name: "Poppins-Medium", size: 36)
        
        return title
    }()
    
    //MARK: Stack description and Title
    private lazy var textsStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [descriptionTitleLabel, titleLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 0
        
        return stack
    }()
    
    //MARK: List Clipboard Icon
    private lazy var icon: UIImageView = {
        var icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.image = UIImage(systemName: "list.bullet.clipboard")
        icon.tintColor = .textAndIcons
        
        return icon
    }()
    
    //MARK: Stack Texts and Icon
    private lazy var iconAndTextStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [textsStack, icon])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 120
        stack.alignment = .center
        stack.layer.cornerRadius = 12
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        stack.addGestureRecognizer(tapGesture)
        stack.isUserInteractionEnabled = true
        return stack
    }()
    
    private lazy var cardBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    //MARK: Properties
    func configure(title: String, subTitle: String, bgColor: UIColor? = nil) {
        titleLabel.text = title
        descriptionTitleLabel.text = subTitle
        //iconAndTextStack.backgroundColor = bgColor
        cardBackgroundView.backgroundColor = bgColor ?? .primary
    }
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        isUserInteractionEnabled = true // Garante que o componente recebe eventos
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var listCardTapped: () -> Void = {}
    
    @objc func buttonTapped() {
        listCardTapped()
    }

}

extension ListCardCollectionViewCell: ViewCodeProtocol {
    func addSubViews() {
        addSubview(cardBackgroundView)
        cardBackgroundView.addSubview(iconAndTextStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            cardBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cardBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cardBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            cardBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            iconAndTextStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            iconAndTextStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            iconAndTextStack.topAnchor.constraint(equalTo: self.topAnchor),
            iconAndTextStack.heightAnchor.constraint(equalToConstant: 104),
            
            textsStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            icon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            icon.heightAnchor.constraint(equalToConstant: 43),
            icon.widthAnchor.constraint(equalToConstant: 40),
            
            textsStack.centerYAnchor.constraint(equalTo: iconAndTextStack.centerYAnchor)
            
        ])
    }
}

