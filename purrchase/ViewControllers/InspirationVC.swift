//
//  InspirationVC.swift
//  purrchase
//
//  Created by Diogo Camargo on 13/05/25.
//

import UIKit

class InspirationVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    lazy var welcomeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome To Inspiration"
        label.font = UIFont(name: "Quicksand-Bold", size: 32)
        return label
    } ()
    
    lazy var amount: AmountComponent = {
        var amount = AmountComponent()
        amount.translatesAutoresizingMaskIntoConstraints = false
        return amount
    }()
    
}

extension InspirationVC: ViewCodeProtocol {
    
    func addSubViews() {
        view.addSubview(welcomeLabel)
        view.addSubview(amount)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            amount.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 24),
            amount.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            amount.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
    }
    
    func setupViews() {
        addSubViews()
        setupConstraints()
    }
}