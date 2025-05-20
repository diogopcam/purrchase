//
//  Validatable.swift
//  purrchase
//
//  Created by Diogo Camargo on 19/05/25.
//


protocol Validatable {
    func validate() -> Bool
    var errorMessage: String? { get }
}
