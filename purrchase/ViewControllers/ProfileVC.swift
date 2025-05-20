//
//  ProfileVC.swift
//  purrchase
//
//  Created by Diogo Camargo on 13/05/25.
//

import UIKit

class ProfileVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - UI Components
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Profile-Icon")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 24
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 102).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 102).isActive = true
        return imageView
    }()
    
    lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Your name"
        label.font = UIFont(name: "Poppins-Medium", size: 24)
        return label
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .backgroundPrimaria
        button.layer.cornerRadius = 17
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return button
    }()
    
    // MARK: - App Settings Section
    
    lazy var switchComponentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "App Settings"
        label.font = UIFont(name: "Poppins-Medium", size: 14)
        label.textColor = .grayText
        return label
    }()
    
    lazy var switchImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Light-Icon")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.widthAnchor.constraint(equalToConstant: 26).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 26).isActive = true
        return imageView
    }()
    
    lazy var switchLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Light Theme"
        label.font = UIFont(name: "Poppins-SemiBold", size: 17)
        return label
    }()
    
    lazy var switchSwitch: UISwitch = {
        let switchComponent = UISwitch()
        switchComponent.translatesAutoresizingMaskIntoConstraints = false
        switchComponent.onTintColor = .textAndIcons
        switchComponent.isOn = true
        return switchComponent
    }()
    
    lazy var notifImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Notification-Icon")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.widthAnchor.constraint(equalToConstant: 26).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 26).isActive = true
        return imageView
    }()
    
    lazy var notifLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Allow Notifications"
        label.font = UIFont(name: "Poppins-SemiBold", size: 17)
        return label
    }()
    
    lazy var notifSwitch: UISwitch = {
        let switchComponent = UISwitch()
        switchComponent.translatesAutoresizingMaskIntoConstraints = false
        switchComponent.onTintColor = .textAndIcons
        switchComponent.isOn = true
        return switchComponent
    }()
    
    // MARK: - Share Section
    
    lazy var shareComponentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Share"
        label.font = UIFont(name: "Poppins-Medium", size: 14)
        label.textColor = .grayText
        return label
    }()
    
    lazy var shareImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Share-Icon")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.widthAnchor.constraint(equalToConstant: 26).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 26).isActive = true
        return imageView
    }()
    
    lazy var shareLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Share App"
        label.font = UIFont(name: "Poppins-SemiBold", size: 17)
        return label
    }()
    
    lazy var shareListImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Sheet-Icon")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.widthAnchor.constraint(equalToConstant: 26).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 26).isActive = true
        return imageView
    }()
    
    lazy var shareListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Share Your List"
        label.font = UIFont(name: "Poppins-SemiBold", size: 17)
        return label
    }()
    
    // MARK: - Contact Section
    
    lazy var contactComponentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Contact"
        label.font = UIFont(name: "Poppins-Medium", size: 14)
        label.textColor = .grayText
        return label
    }()
    
    lazy var contactImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Message-Icon")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.widthAnchor.constraint(equalToConstant: 26).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 26).isActive = true
        return imageView
    }()
    
    lazy var contactLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Contact Us"
        label.font = UIFont(name: "Poppins-SemiBold", size: 17)
        return label
    }()
    
    // MARK: - Stack Views
    
    lazy var imageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImage, profileLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var themeHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [switchImage, switchLabel, UIView(), switchSwitch])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()
    
    lazy var notifHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [notifImage, notifLabel, UIView(), notifSwitch])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()
    
    lazy var switchComponentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [themeHorizontalStack, notifHorizontalStack])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .backgroundPrimaria
        stackView.layer.cornerRadius = 17
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 16
        return stackView
    }()
    
    lazy var shareHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [shareImage, shareLabel, UIView()])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()
    
    lazy var shareListHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [shareListImage, shareListLabel, UIView()])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()
    
    lazy var shareComponentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [shareHorizontalStack, shareListHorizontalStack])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .backgroundPrimaria
        stackView.layer.cornerRadius = 17
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 16
        return stackView
    }()
    
    lazy var contactHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [contactImage, contactLabel, UIView()])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()
    
    lazy var contactComponentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [contactHorizontalStack])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .backgroundPrimaria
        stackView.layer.cornerRadius = 17
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return stackView
    }()
}

extension ProfileVC: ViewCodeProtocol {
    
    func addSubViews() {
        view.addSubview(imageStackView)
        view.addSubview(loginButton)
        view.addSubview(switchComponentLabel)
        view.addSubview(switchComponentStackView)
        view.addSubview(shareComponentLabel)
        view.addSubview(shareComponentStackView)
        view.addSubview(contactComponentLabel)
        view.addSubview(contactComponentStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Profile Image Stack
            imageStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -16),
            imageStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Login Button
            loginButton.topAnchor.constraint(equalTo: imageStackView.bottomAnchor, constant: 12),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 165),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -165),
            
            // App Settings Section
            switchComponentLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 24),
            switchComponentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            switchComponentStackView.topAnchor.constraint(equalTo: switchComponentLabel.bottomAnchor, constant: 8),
            switchComponentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            switchComponentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // Share Section
            shareComponentLabel.topAnchor.constraint(equalTo: switchComponentStackView.bottomAnchor, constant: 24),
            shareComponentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            shareComponentStackView.topAnchor.constraint(equalTo: shareComponentLabel.bottomAnchor, constant: 8),
            shareComponentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            shareComponentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // Contact Section
            contactComponentLabel.topAnchor.constraint(equalTo: shareComponentStackView.bottomAnchor, constant: 24),
            contactComponentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            
            contactComponentStackView.topAnchor.constraint(equalTo: contactComponentLabel.bottomAnchor, constant: 8),
            contactComponentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contactComponentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contactComponentStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        addSubViews()
        setupConstraints()
    }
}
