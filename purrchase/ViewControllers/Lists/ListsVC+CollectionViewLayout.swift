//
//  ListsVC+CollectionViewLayout.swift
//  purrchase
//
//  Created by Maria Santellano on 19/05/25.
//

import UIKit

extension ListsVC {
    func createSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
             heightDimension: .absolute(104))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10.0
        section.contentInsets = NSDirectionalEdgeInsets(top: 16.0, leading: 16.0, bottom: 16.0, trailing: 16.0)
        
        return section
    }

    func createAllLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            switch sectionIndex {
            default:
                return self.createSection()
            }
        }
        
        return layout
    }
}
