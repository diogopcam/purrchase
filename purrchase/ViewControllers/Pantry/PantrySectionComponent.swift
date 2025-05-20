//
//  PantrySectionComponent.swift
//  purrchase
//
//  Created by Bernardo Garcia Fensterseifer on 19/05/25.
//

import UIKit

class PantrySectionComponent: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
//    lazy var collectionView: UICollectionView = {
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createAllLayout())
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
//        collectionView.dataSource = self
//        return collectionView
//    }()
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
