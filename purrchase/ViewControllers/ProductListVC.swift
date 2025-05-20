//
//  ProductListVC.swift
//  purrchase
//
//  Created by Bernardo Garcia Fensterseifer on 14/05/25.
//

import UIKit

class ProductListVC: UIViewController {
    let controller: ProductListController
    let productList: ProductList

    private func updateCatIconVisibility() {
        catIcon.isHidden = !productList.list.isEmpty
    }
    
    init(controller: ProductListController, productList: ProductList) {
        self.controller = controller
        self.productList = productList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCatIconVisibility()

        print("📦 Produtos da lista \(productList.name):")
        for product in productList.list {
            print("- \(product.name)")
        }
        
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "NavBar-Icon1"),
            style: .plain,
            target: self,
            action: #selector(handleAddProduct)
        )
        
        navigationController?.navigationBar.tintColor = .textAndIcons
        setupViews()
    }
    
    @objc func handleAddProduct() {
        print("Add Product Tapped!")
        // ainda será implementado
    }
    
    @objc func addProductTapped() {
        let addProductVC = AddProductVC(controller: controller, productList: productList)
        addProductVC.delegate = self
        present(addProductVC, animated: true)
    }

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = productList.name
        label.font = UIFont(name: "Quicksand-Bold", size: 40)
        return label
    }()

    lazy var addProductButton: AddListComponent = {
        let button = AddListComponent()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.name = "Add Products"
        button.addListButtonAction = { [weak self] in
            self?.addProductTapped()
        }
        return button
    }()

    lazy var catIcon: ImageCatComponent = {
        let catIcon = ImageCatComponent()
        catIcon.translatesAutoresizingMaskIntoConstraints = false
        catIcon.image = .catBackground2
        catIcon.name = "Click on “Add Products” to add a new products"
        return catIcon
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
}

extension ProductListVC: ViewCodeProtocol {
    
    func addSubViews() {
        view.addSubview(titleLabel)
        view.addSubview(addProductButton)
        view.addSubview(collectionView)
        view.addSubview(catIcon)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 98),
            titleLabel.heightAnchor.constraint(equalToConstant: 52),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            addProductButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            addProductButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addProductButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addProductButton.heightAnchor.constraint(equalToConstant: 52),
            
            catIcon.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 203),
            catIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 93),
            catIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -94),
            
            collectionView.topAnchor.constraint(equalTo: addProductButton.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupViews() {
        addSubViews()
        setupConstraints()
    }
}

extension ProductListVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.list.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CardCollectionViewCell.identifier,
            for: indexPath) as? CardCollectionViewCell else {
            fatalError("Unable to dequeue CardCollectionViewCell")
        }

        let product = productList.list[indexPath.item]
        cell.configure(title: product.name, pImage: .apple)
        return cell
    }
}

extension ProductListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let totalSpacing = 12 * 3 // 3 espaços entre 4 itens
        let width = (collectionView.bounds.width - CGFloat(totalSpacing)) / 4
        return CGSize(width: width, height: 100)
    }
}

extension ProductListVC: AddProductDelegate {
    func didAddProduct(_ product: Product) {
        productList.list.append(product)
        updateCatIconVisibility()
        collectionView.reloadData()
    }
}
