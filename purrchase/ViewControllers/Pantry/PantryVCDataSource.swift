//
//  PantryVCDataSource.swift
//  purrchase
//
//  Created by Bernardo Garcia Fensterseifer on 19/05/25.
//

import UIKit

// MARK: - UICollectionViewDataSource
extension PantryVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView1 {
            return products.count
        } else if collectionView == collectionView2 {
            return productsCloseToExpiration.count
        } else if collectionView == collectionView3 {
            return productsExpired.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CardCollectionViewCell.identifier,
            for: indexPath
        ) as? CardCollectionViewCell else {
            fatalError("Unable to dequeue CardCollectionViewCell")
        }

        let product: PantryProduct

        if collectionView == collectionView1 {
            product = products[indexPath.item]
        } else if collectionView == collectionView2 {
            product = productsCloseToExpiration[indexPath.item]
        } else {
            product = productsExpired[indexPath.item]
        }

        let productName = product.name
        cell.configure(title: productName, pImage: product.image) {
            print("Image tapped at index \(indexPath.item)")
            let editProductVC = EditProductVC()
            self.present(editProductVC, animated: true)
        }
        
        return cell
    }
}
