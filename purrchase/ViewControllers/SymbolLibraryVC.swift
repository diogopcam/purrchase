////
////  SymbolLibraryDelegate.swift
////  Purrchase
////
////  Created by Diogo Camargo on 22/05/25.
////


import UIKit

protocol SymbolLibraryDelegate: AnyObject {
    func didSelectSymbol(image: UIImage)
}

class SymbolLibraryVC: UIViewController {
    
    weak var delegate: SymbolLibraryDelegate?
    private var selectedSymbol: SymbolItem?
    
    // MARK: - UI Components
    lazy var header: NavBarComponent = {
        var header = NavBarComponent()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.firstButtonTitle = "Cancel"
        header.title = "Products"
        header.secondButtonTitle = "Done"
        
        header.firstButtonTitle = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        header.secondButtonTitle = { [weak self] in
            self?.doneButtonTapped()
        }
        
        return header
    }()
    
    func doneButtonTapped() {
        dismiss(animated: true)
    }
    
    private let symbolSections: [(title: String, symbols: [SymbolItem])] = [
        ("Vegetables", [
            SymbolItem(emoji: "🥕", name: "Carrot"),
            SymbolItem(emoji: "🧄", name: "Garlic"),
            SymbolItem(emoji: "🧅", name: "Onion"),
            SymbolItem(emoji: "🥦", name: "Broccoli"),
            SymbolItem(emoji: "🌽", name: "Corn")
        ]),
        ("Fruits", [
            SymbolItem(emoji: "🍎", name: "Apple"),
            SymbolItem(emoji: "🍌", name: "Banana"),
            SymbolItem(emoji: "🍇", name: "Grapes"),
            SymbolItem(emoji: "🍉", name: "Watermelon"),
            SymbolItem(emoji: "🍓", name: "Strawberry")
        ]),
        ("Meats", [
            SymbolItem(emoji: "🥩", name: "Steak"),
            SymbolItem(emoji: "🍗", name: "Chicken Leg"),
            SymbolItem(emoji: "🍖", name: "Meat")
        ]),
        ("Bread", [
            SymbolItem(emoji: "🍞", name: "Bread"),
            SymbolItem(emoji: "🥐", name: "Croissant"),
            SymbolItem(emoji: "🥖", name: "Baguette")
        ]),
        ("Sweets", [
            SymbolItem(emoji: "🍫", name: "Chocolate"),
            SymbolItem(emoji: "🍩", name: "Donut"),
            SymbolItem(emoji: "🍪", name: "Cookie"),
            SymbolItem(emoji: "🍰", name: "Cake")
        ]),
        ("Drinks", [
            SymbolItem(emoji: "☕️", name: "Coffee"),
            SymbolItem(emoji: "🥤", name: "Soda"),
            SymbolItem(emoji: "🍷", name: "Wine"),
            SymbolItem(emoji: "🍺", name: "Beer")
        ]),
        ("Hygiene", [
            SymbolItem(emoji: "🧼", name: "Soap"),
            SymbolItem(emoji: "🪥", name: "Toothbrush"),
            SymbolItem(emoji: "🧴", name: "Lotion")
        ]),
        ("Pet Supplies", [
            SymbolItem(emoji: "🐶", name: "Dog"),
            SymbolItem(emoji: "🐱", name: "Cat"),
            SymbolItem(emoji: "🦴", name: "Bone")
        ]),
        ("Medicine", [
            SymbolItem(emoji: "💊", name: "Pill"),
            SymbolItem(emoji: "🩹", name: "Bandage"),
            SymbolItem(emoji: "🩺", name: "Stethoscope")
        ]),
        ("Dairy", [
            SymbolItem(emoji: "🥛", name: "Milk"),
            SymbolItem(emoji: "🧀", name: "Cheese"),
            SymbolItem(emoji: "🍦", name: "Ice Cream")
        ])
    ]

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        collectionView.register(SectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderView.identifier)
        
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(header)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            header.topAnchor.constraint(equalTo: view.topAnchor, constant: 11),
            collectionView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}


extension SymbolLibraryVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeaderView.identifier,
                for: indexPath) as? SectionHeaderView else {
                return UICollectionReusableView()
            }
            let title = symbolSections[indexPath.section].title
            header.configure(with: title)
            return header
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 40)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return symbolSections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return symbolSections[section].symbols.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CardCollectionViewCell.identifier,
            for: indexPath) as? CardCollectionViewCell else {
            fatalError("Unable to dequeue CardCollectionViewCell")
        }
        

        let item = symbolSections[indexPath.section].symbols[indexPath.item]
        let image = item.emoji.emojiToImage() ?? UIImage()
        
        cell.configure(title: item.name, pImage: image) {
            self.selectedSymbol = item
            self.delegate?.didSelectSymbol(image: image)
            self.dismiss(animated: true)
        }
        
        return cell
    }
}

extension SymbolLibraryVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let totalSpacing = 12 * 3 // 3 espaços entre 4 itens
        let width = (collectionView.bounds.width - CGFloat(totalSpacing) - 40) / 4
        return CGSize(width: width, height: 125)
    }
}

class SectionHeaderView: UICollectionReusableView {
    static let identifier = "SectionHeaderView"
    
    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func configure(with title: String) {
        label.text = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension String {
    func emojiToImage(fontSize: CGFloat = 100) -> UIImage? {
        let renderSize = CGSize(width: fontSize * 1.2, height: fontSize * 1.2)
        let renderer = UIGraphicsImageRenderer(size: renderSize)

        return renderer.image { context in
            // Usa a cor do asset "Background-Yellow" como fundo
            let backgroundColor = UIColor(named: "Background-Yellow") ?? UIColor.yellow
            backgroundColor.setFill()
            context.fill(CGRect(origin: .zero, size: renderSize))

            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "AppleColorEmoji", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
            ]

            let textSize = self.size(withAttributes: attributes)
            let rect = CGRect(
                x: (renderSize.width - textSize.width) / 2,
                y: (renderSize.height - textSize.height) / 2,
                width: textSize.width,
                height: textSize.height
            )

            self.draw(in: rect, withAttributes: attributes)
        }
    }
}
