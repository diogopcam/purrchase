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
    
    lazy var welcomeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome To Profile"
        label.font = UIFont(name: "Quicksand-Bold", size: 32)
        return label
    } ()
}

extension ProfileVC: ViewCodeProtocol {
    
    func addSubViews() {
        view.addSubview(welcomeLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24)
        ])
    }
    
    func setupViews() {
        addSubViews()
        setupConstraints()
    }
}

