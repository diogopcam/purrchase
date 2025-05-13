//
//  ViewCodeProtocol.swift
//  purrchase
//
//  Created by Diogo Camargo on 13/05/25.
//

import Foundation

protocol ViewCodeProtocol {
    func addSubViews()
    func setupConstraints()
    func setup()
}

extension ViewCodeProtocol {
    func setup() {
        addSubViews()
        setupConstraints()
    }
}
