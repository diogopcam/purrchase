//
//  ProductList.swift
//  purrchase
//
//  Created by Diogo Camargo on 19/05/25.
//

import UIKit

import Foundation

class ProductList: Codable {
    var id = UUID()
    var list: [Product]
    var colorName: String  // Nome da cor no Assets
    var name: String

    init(list: [Product], colorName: String, name: String) {
        self.list = list
        self.colorName = colorName
        self.name = name
    }

    // Computed property para recuperar a cor real
    var color: UIColor? {
        return UIColor(named: colorName)
    }
}
