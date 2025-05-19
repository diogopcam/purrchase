//
//  PantryVCDataSource.swift
//  purrchase
//
//  Created by Bernardo Garcia Fensterseifer on 19/05/25.
//

import UIKit

// MARK: CollectionView DataSource
extension PantryVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItens = 4
        // aqui terao alteracoes
        // pegar a qtde de itens do banco de dados e dividir por 4 -> isso nos daria a qtde de grupos (que teriam 4 itens em cada e no fim, o ultimo grupo teria qtdeProdutos%4)
        return numberOfItens
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as? CardCollectionViewCell
        else { fatalError() }
        
        // aqui seria um laço for percorrendo o "banco de dados" do usuario. salvar o nome do produto e enviá-lo como parametro no metodo configure()
        cell.configure(title: "Apple", pImage: .apple)
                
        return cell
    }
    
}
