//
//  ListsVC.swift
//  purrchase
//
//  Created by Diogo Camargo on 13/05/25.
//

import UIKit

class ListsVC: UIViewController {

    let productListController: ProductListController
    weak var delegate: DeleteListDelegate?

    init(productListController: ProductListController) {
        self.productListController = productListController
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

        let placeholderList = ProductList(
            list: [],
            colorName: "Circle-4",
            name: "Rancho"
            )

        empty.listCardTapped = { [weak self] in
            self?.didTapListCard(with: placeholderList)
        }

        return empty
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createAllLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ListCardCollectionViewCell.self, forCellWithReuseIdentifier: ListCardCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    @objc func addListButtonTapped() {
        let addListVC = AddListVC(controller: productListController)
        addListVC.delegate = self
        present(addListVC, animated: true)
    }

    var sections: [ProductList] {
        return productListController.lists
    }
}

// MARK: Funções do botão
extension ListsVC {
    func didTapListCard(with list: ProductList) {
        print("Botão clicado - \(list.name)")
        let productListVC = ProductListVC(controller: productListController, productList: list)
        productListVC.delegate = self // <--- Aqui!
    
        let backButton = UIBarButtonItem(title: "Lists", style: .plain, target: nil, action: nil)
        backButton.tintColor = .textAndIcons
        navigationItem.backBarButtonItem = backButton
        navigationController?.pushViewController(productListVC, animated: true)
    }
}

extension ListsVC: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       collectionView.isHidden = sections.isEmpty
        return sections.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCardCollectionViewCell.identifier, for: indexPath) as? ListCardCollectionViewCell
        else { fatalError() }

        let list = sections[indexPath.item]

        cell.configure(title: list.name, subTitle: "", bgColor: list.color)

        cell.listCardTapped = { [weak self] in
            guard let self = self else { return }
            let selectedList = self.sections[indexPath.item]  // <- a lista clicada
            self.didTapListCard(with: selectedList)
        }

        return cell
    }
}

extension ListsVC: DeleteListDelegate {
    func didDeleteList(_ productList: ProductList) {
        print("Lista de Produtos deletado: \(productList.name)")
        collectionView.reloadData()
    }
}
