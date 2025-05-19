//
//  ListsVC.swift
//  purrchase
//
//  Created by Diogo Camargo on 13/05/25.
//

import UIKit

class ListsVC: UIViewController {

    lazy var welcomeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome To Purrchase!"
        label.font = UIFont(name: "Quicksand-Bold", size: 32)
        label.textColor = .tertiary
        return label
    } ()
    
    lazy var yellowView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .backgroundYellow
        view.addSubview(welcomeLabel)
        return view
    }()
    
    lazy var addListButton: AddListComponent = {
        var button = AddListComponent()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addListButtonAction = { [weak self] in
            self?.addListButtonTapped()
        }

        return button
    }()
    
    //MARK: Empty State 
    lazy var emptyState: EmptyStateComponent = {
        var empty = EmptyStateComponent()
        empty.image = .catBackground1
        empty.translatesAutoresizingMaskIntoConstraints = false
        empty.listCardTapped = { [weak self] in
            self?.didTapListCard()
        }
        
        return empty
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createAllLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ListCardCollectionViewCell.self, forCellWithReuseIdentifier: ListCardCollectionViewCell.identifier)
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc func addListButtonTapped() {
        let addListVC = AddListVC()
//        addListVC.delegate = self //Falta fazer essa parte
        present(addListVC, animated: true)
    }
}


// MARK: Funções do botão
extension ListsVC {
    @objc private func didTapListCard() {
        print("Botao clicado")
        let productsVC = ProductsVC()
        let backButton = UIBarButtonItem(title: "Lists", style: .plain, target: nil, action: nil)
        backButton.tintColor = .textAndIcons
        navigationItem.backBarButtonItem = backButton
        navigationController?.pushViewController(productsVC, animated: true)
    }
    
    @objc private func addList() {
        /// implementar quando tiver todas as ferramentas para tal
    }
}

extension ListsVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCardCollectionViewCell.identifier, for: indexPath) as? ListCardCollectionViewCell
        else { fatalError() }
        
//        cell.configure(title: indexPath.description, subTitle: indexPath.description, bgColor: UIColor.systemOrange)
        
        cell.listCardTapped = { [weak self] in
            self?.didTapListCard()
        }
        
        cell.configure(title: "A", subTitle: "K", bgColor: .circle2)
                
        return cell
    }
    
}

