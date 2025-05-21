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
    weak var delegate: DeleteListDelegate? // <--- Adicione isso
    
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
        
        view.addSubview(popupView)
            popupView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                popupView.topAnchor.constraint(equalTo: view.topAnchor, constant: 101),
                popupView.widthAnchor.constraint(equalToConstant: 250),
                popupView.heightAnchor.constraint(equalToConstant: 139)
            ])
            
            // Add tap gesture to dismiss when tapping outside
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopup))
            tapGesture.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGesture)
    }
    
    // 1. Declare the view as a property at the top of your class
    private lazy var popupView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 12
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 8
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.isHidden = true
        view.alpha = 0
        
        // Add your image view
        let imageView = UIImageView(image: UIImage(named: "tresPontinhos"))
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        
        let deleteButton = UIButton(type: .system)
        deleteButton.setTitle("", for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteList), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(deleteButton)
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 88),
            deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        
        return view
    }()

    // 3. Button action
    @objc func handleAddProduct() {
        print("Add Product Tapped!")
        showPopup()
    }

    // 4. Show/hide methods
    private func showPopup() {
        popupView.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.popupView.alpha = 1
        }
    }

    @objc private func dismissPopup() {
        UIView.animate(withDuration: 0.3, animations: {
            self.popupView.alpha = 0
        }) { _ in
            self.popupView.isHidden = true
        }
    }
    
    //MARK: delete list
    @objc func deleteList() {
        controller.removeListByID(productList.id)
        dismissPopup()
        delegate?.didDeleteList(productList) // <--- Notifica a tela anterior
        navigationController?.popViewController(animated: true)
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
    
//    func refreshProductListData() {
//        // Atualiza os dados
//        var productListProducts = controller.lists
//
//        // Atualiza as collectionViews
//        collectionView.reloadData()
//    }
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
        // REMOVA ESTA LINHA: collectionView.dataSource = self

        let product = productList.list[indexPath.item]
        cell.configure(title: product.name, pImage: product.image)
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
        collectionView.reloadData()
        print("Produto adicionado: \(product.name)")
    }
}

protocol DeleteListDelegate: AnyObject {
    func didDeleteList(_ productList: ProductList)
}
