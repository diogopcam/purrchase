//
//  PantryVCViewLayout.swift
//  purrchase
//
//  Created by Bernardo Garcia Fensterseifer on 19/05/25.
//

import UIKit

// MARK: CollectionView Layout
extension PantryVC {
    
    func createSection() -> Section {
        
        /// item
        let itemSize = Size(widthDimension: .absolute(78), heightDimension: .absolute(100))
        let item = Item(layoutSize: itemSize)
        
        /// group
        let groupSize = Size(widthDimension: .estimated(402), heightDimension: .absolute(100))
        let group = Group.horizontal(layoutSize: groupSize, subitems: [item])
        
        /// section
        let section = Section(group: group)
        section.interGroupSpacing = 20
        section.contentInsets = Edges(top: 16, leading: 16, bottom: 16, trailing: 16)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        /// layout
//        let layout = Layout(section: section)
        
        return section
    }
    
    func createAllLayout() -> UICollectionViewLayout {
        
        let layout = Layout { sectionIndex, layoutEnvironment in
            return self.createSection()
        }
        
        return layout
    }
    
}
