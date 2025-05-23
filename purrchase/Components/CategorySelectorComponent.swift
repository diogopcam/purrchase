//
//  CategorySelectorComponent.swift
//  purrchase
//
//  Created by Maria Santellano on 15/05/25.
//

import UIKit

class CategorySelectorComponent: UIView {

    //MARK: Category Label
    private lazy var label: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "Poppins-Medium", size: 17)
        label.textColor = .black
        
        return label
        
    }()
    
    //MARK: Category Selector Button
    private lazy var categoryButton: UIButton = {
        var button = UIButton()
        var configuration = UIButton.Configuration.plain()
        
        configuration.baseForegroundColor = UIColor(named: "Text-and-Icons") ?? .black
        
        let title = AttributedString("Select", attributes: AttributeContainer([
            .foregroundColor: UIColor(named: "Text-and-Icons") ?? .black,
            .font: UIFont(name: "Poppins-SemiBold", size: 18) ?? .systemFont(ofSize: 18)
            ]))
            configuration.attributedTitle = title
        
        configuration.indicator = .popup
        button.configuration = configuration
        
        button.menu = UIMenu(title: "Category", options: [.singleSelection], children: categorySelection)

        button.showsMenuAsPrimaryAction = true
        
        return button
    }()
    
    //MARK: Stack
    private lazy var categoryStack: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [label, categoryButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .backgroundPrimaria
        stack.layer.cornerRadius = 17
        stack.distribution = .equalSpacing
        
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        
        return stack
    }()

    var categorySelection: [UIAction] {
        return Category.allCases.sorted(by: { $0.rawValue < $1.rawValue })
            .map { category in
                UIAction(
                    title: category.rawValue,
                    handler: { [weak self] _ in
                        self?.selectedCategory = category
                    }
                )
            }
    }

    
    var selectedCategory: Category? {
        didSet {
            categoryButton.setTitle(
                selectedCategory?.rawValue ?? "Select",
                for: .normal
            )
        }
    }
    
    var labelTitle: String? {
        didSet {
            label.text = labelTitle
        }
    }
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension CategorySelectorComponent: ViewCodeProtocol {
    
    func addSubViews() {
        addSubview(categoryStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
                       
            categoryStack.topAnchor.constraint(equalTo: self.topAnchor),
            categoryStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            categoryStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            categoryStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            categoryStack.heightAnchor.constraint(equalToConstant: 60),
            
        ])
    }
}
