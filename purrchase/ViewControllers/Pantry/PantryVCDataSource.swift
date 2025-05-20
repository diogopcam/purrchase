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
        
        let numberOfItens = products.count
        
        // aqui terao alteracoes
        // pegar a qtde de itens do banco de dados e dividir por 4 -> isso nos daria a qtde de grupos (que teriam 4 itens em cada e no fim, o ultimo grupo teria qtdeProdutos%4)
        
        return numberOfItens
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as? CardCollectionViewCell
        else { fatalError() }
        
        // aqui seria um laço for percorrendo o UserDefaults do usuario. salvar o nome do produto e enviá-lo como parametro no metodo configure()
        
        // como eu vou fazer o código entender que cada collectionView tem uma lista especifica? Arrumar pq nao ta funcionando essa logica
        if collectionView == collectionView1 {
            let productName: String = products[indexPath.item].name
            cell.configure(title: productName, pImage: UIImage(named: productName))
            return cell
        }
        else if collectionView == collectionView2 {
            let productName: String = productsCloseToExpiration[indexPath.item].name
            cell.configure(title: productName, pImage: UIImage(named: productName))
            return cell
        }
        else {
            let productName: String = productsExpired[indexPath.item].name
            cell.configure(title: productName, pImage: UIImage(named: productName))
            return cell
        }
    }
    
}

