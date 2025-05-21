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
        cell.configure(title: product.name, pImage: product.image) {
            // 1) Cria o VC de edição da despensa passando o controller e o produto correto
            let editVC = EditPantryProductVC(controller: self.controller,
                                             product: product)
            // 2) Faz seu VC principal (PantryVC) escutar os callbacks de update/delete
            editVC.delegate = self
            // 3) Apresenta
            self.present(editVC, animated: true)
        }
        
        return cell
    }
}
