//
//  PantryVC.swift
//  purrchase
//
//  Created by Bernardo Garcia on 13/05/25.
//

import UIKit

class PantryVC: UIViewController {
    let controller: PantryController
//    lazy var products: [PantryProduct]
    
    lazy var products: [PantryProduct] = {
        var productList = controller.getPantryItems()
        return productList
    }()
    lazy var productsCloseToExpiration: [PantryProduct] = { // revisar logica
        var productList: [PantryProduct] = []
        for product in products {
            if product.expirationDate! < Date().addingTimeInterval(259200) { // equivalente a 3 dias (ta em segundos)
                productList.append(product)
            }
        }
        return productList
    }()
    lazy var productsExpired: [PantryProduct] = {
        var productList: [PantryProduct] = []
        for product in products {
            if product.expirationDate! < Date() {
                productList.append(product)
            }
        }
        return productList
    }()
    
    // Inicializador customizado
    init(controller: PantryController) {
        self.controller = controller
        super.init(nibName: nil, bundle: nil)
    }

    // Obrigatório quando você customiza o init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ScrollView Container
        private lazy var scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.showsVerticalScrollIndicator = true
            return scrollView
        }()

        private lazy var contentStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.spacing = 24
            return stackView
        }()
    

    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pantry"
        label.font = UIFont(name: "Quicksand-Bold", size: 40)
        label.textColor = .label
        return label
    } ()
    
    lazy var addProductButton: AddListComponent = {
        var button = AddListComponent()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.name = "Add Products"
        button.addListButtonAction = { [weak self] in
            self?.addProductTapped()
        }
                
        return button
    }()
    
    lazy var catIcon: ImageCatComponent = {
        var catIcon = ImageCatComponent()
        catIcon.translatesAutoresizingMaskIntoConstraints = false
        catIcon.image = .catBackground2
        catIcon.name = "Click on “Add Products” to add a new products"
        return catIcon
    }()
    
//    lazy var emptyState: EmptyStateComponent = {
//        var emptyState = EmptyStateComponent()
//        emptyState.translatesAutoresizingMaskIntoConstraints = false
//        return emptyState
//    }
    
    // MARK: all products
    lazy var sectionTitle1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-SemiBold", size: 20)
        label.text = "All Products"
        return label
    }()
    
    /// aqui aparece tudo
    lazy var collectionView1: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createAllLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        collectionView.dataSource = self
        return collectionView
    }()
    // MARK: close to expiration date
    lazy var sectionTitle2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-SemiBold", size: 20)
        label.text = "Close to Expiration Date"
        return label
    }()
    /// AQUI TEM QUE APARECER SOMENTE OS ITENS CLOSE TO EXPIRATION DATE
    lazy var collectionView2: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createAllLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        collectionView.dataSource = self
        return collectionView
    }()
    // MARK: expired products
    lazy var sectionTitle3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-SemiBold", size: 20)
        label.text = "Expired Products"
        return label
    }()
    /// AQUI TEM QUE APARECER SOMENTE OS ITENS EXPIRADOS
    lazy var collectionView3: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createAllLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        print("Essa é a lista de produtos da pantry: ")
        for product in products {
            print(product.name, terminator: " / ")
        }
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "NavBar-Icon1"),
            style: .plain,
            target: self,
            action: #selector(handleComponent)
        )
        navigationController?.navigationBar.tintColor = .textAndIcons
    }
    
    var nameTitle: String? {
        get {
            titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
}

extension PantryVC: ViewCodeProtocol {
    
//    func addSubViews() {
//        view.addSubview(titleLabel)
//        view.addSubview(addProductButton)
//        
//        view.addSubview(sectionTitle1)
//        view.addSubview(collectionView1)
//        view.addSubview(sectionTitle2)
//        view.addSubview(collectionView2)
//        view.addSubview(sectionTitle3)
//        view.addSubview(collectionView3)
//        
////        view.addSubview(catIcon)
//    }
//    
//    func setupConstraints() {
//        NSLayoutConstraint.activate([
//            
//            // MARK: titleLabel
//            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 98),
//            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            
//            // MARK: button
//            addProductButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
//            addProductButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            addProductButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            
//            // MARK: catImage
////            catIcon.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 211),
////            catIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 93),
////            catIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -94)
//            
//            // MARK: collectionViews
//            sectionTitle1.topAnchor.constraint(equalTo: addProductButton.bottomAnchor, constant: 24),
//            sectionTitle1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            sectionTitle1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            collectionView1.topAnchor.constraint(equalTo: sectionTitle1.bottomAnchor, constant: 24),
//            collectionView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            collectionView1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0),
//            sectionTitle2.topAnchor.constraint(equalTo: collectionView1.bottomAnchor, constant: 32),
//            sectionTitle2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            sectionTitle2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            collectionView2.topAnchor.constraint(equalTo: sectionTitle2.bottomAnchor, constant: 24),
//            collectionView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            collectionView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0),
//            sectionTitle3.topAnchor.constraint(equalTo: collectionView2.bottomAnchor, constant: 32),
//            sectionTitle3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            sectionTitle3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            collectionView3.topAnchor.constraint(equalTo: sectionTitle3.bottomAnchor, constant: 24),
//            collectionView3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            collectionView3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0),
//            
//            collectionView1.heightAnchor.constraint(equalToConstant: 150),
//            collectionView2.heightAnchor.constraint(equalToConstant: 150),
//            collectionView3.heightAnchor.constraint(equalToConstant: 150)
//            
//        ])
//    }
    
    func addSubViews() {
            // Adiciona a scrollView e a stackView como container principal
            view.addSubview(scrollView)
            scrollView.addSubview(contentStackView)

            // Move todos os seus elementos para dentro da stackView
            contentStackView.addArrangedSubview(titleLabel)
            contentStackView.addArrangedSubview(addProductButton)
            
            contentStackView.addArrangedSubview(sectionTitle1)
            contentStackView.addArrangedSubview(collectionView1)
            contentStackView.addArrangedSubview(sectionTitle2)
            contentStackView.addArrangedSubview(collectionView2)
            contentStackView.addArrangedSubview(sectionTitle3)
            contentStackView.addArrangedSubview(collectionView3)
        }

        func setupConstraints() {
            NSLayoutConstraint.activate([
                // Constraints da scrollView (preenche a tela toda)
                scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

                // Constraints da contentStackView (define o tamanho do conteúdo)
                contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

                // Constraints dos seus elementos (ajustes mínimos para funcionar com a stackView)
                titleLabel.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -16),
                
                addProductButton.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 16),
                addProductButton.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -16),
                
                sectionTitle1.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 16),
                sectionTitle1.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -16),
                
                collectionView1.topAnchor.constraint(equalTo: sectionTitle1.bottomAnchor, constant: 11),
                collectionView1.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
                collectionView1.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
                collectionView1.heightAnchor.constraint(equalToConstant: 115),
                
                sectionTitle2.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 16),
                sectionTitle2.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -16),
                
                collectionView2.topAnchor.constraint(equalTo: sectionTitle2.bottomAnchor, constant: 11),
                collectionView2.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
                collectionView2.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
                collectionView2.heightAnchor.constraint(equalToConstant: 115),
                
                sectionTitle3.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 16),
                sectionTitle3.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -16),
                
                collectionView3.topAnchor.constraint(equalTo: sectionTitle3.bottomAnchor, constant: 11),
                collectionView3.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
                collectionView3.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
                collectionView3.heightAnchor.constraint(equalToConstant: 115)
            ])
        }

    
    func setupViews() {
        addSubViews()
        setupConstraints()
    }
}


// MARK: Funções do botão
extension PantryVC {
    
    @objc func handleComponent() {
        print("component tapped")
        /// implementar quando der
    }
    
    @objc func addProductTapped() {
        print("Add Product Tapped")
        let addProductVC = AddProductPantryVC(controller: controller)
//        addProductVC.delegate = self //Falta fazer essa parte
        present(addProductVC, animated: true)
    }
    
}
