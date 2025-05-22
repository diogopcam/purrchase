//
//  PantryVCDataSource.swift
//  purrchase
//
//  Created by Bernardo Garcia Fensterseifer on 19/05/25.
//

import UIKit

// MARK: - UICollectionViewDataSource
extension CookiesModalVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CardCollectionViewCell.identifier,
            for: indexPath
        ) as? CardCollectionViewCell else {
            fatalError("Unable to dequeue CardCollectionViewCell")
        }
        
        // Check indexPath.item (not cell.indexPath)
        switch indexPath.item {
        case 0:
            cell.configure(title: "Butter", pImage: .butter)
        case 1:
            cell.configure(title: "Sugar", pImage: .sugar)
        case 2:
            cell.configure(title: "Brown Sugar", pImage: .brownSugar)
        case 3:
            cell.configure(title: "Egg", pImage: .egg)
        default:
            cell.configure(title: "Banana", pImage: .banana)
        }
        
        return cell
    }
}
