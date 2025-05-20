//
//  ListsVC+AddListDelegate.swift
//  purrchase
//
//  Created by Maria Santellano on 19/05/25.
//

import UIKit

extension ListsVC: AddListDelegate {
    func didAddList(list: ProductList) {
        productListController.repository.printAllProducts()
        collectionView.reloadData()
    }
}
