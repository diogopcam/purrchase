import UIKit

class CookiesModalVC: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        // Configure modal to take 2/3 of screen
        self.modalPresentationStyle = .pageSheet
        if let sheet = sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true // Adds a grabber handle
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    
    // Background Cookie Image
    lazy var backgroundCookieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        //imageView.alpha = 0.1
        // TODO: Replace "cookie_image" with your actual image asset name
        imageView.image = .lukadoncic
        return imageView
    }()
    
    // Header
    lazy var header: StyleNavBarComponent = {
        let header = StyleNavBarComponent()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.title = "Cookies"
        header.subtitle = "Preparation Method: 40min"
        return header
    }()
    
    // Ingredients Section
    lazy var ingredientsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ingredients"
        label.font = UIFont(name: "Poppins-SemiBold", size: 20)
        label.textColor = .black
        return label
    }()
    
    // Ingredients Collection View
    lazy var ingredientsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createAllLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        collectionView.dataSource = self
        return collectionView
    }()
    
    let ingredients = ["Butter", "Sugar", "Brown Sugar", "Egg"]
    
    // Instructions Section
    lazy var instructionsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cooking Instruction"
        label.font = UIFont(name: "Poppins-SemiBold", size: 20)
        label.textColor = .black
        return label
    }()
    
    lazy var instructionsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        
        let steps = [
            "Mix 125 g of unsalted butter at room temperature, 1/2 cup of brown sugar, 3/4 cup of sugar, 1 teaspoon of vanilla essence (add 1/4 cup of chocolate powder, if you are making chocolate-based cookies).",
            "Add 1 beaten egg little by little and mix well.",
            "Add 1 and 3/4 cups wheat flour little by little and mix well (you can do this by hand or with a stand mixer).",
            "Finally, add 1 teaspoon of baking powder and mix just to incorporate it into the dough.",
            "After the dough is well mixed, add 300 g of chopped semi-sweet chocolate",
            "Shape into small balls and bake in a preheated oven, on parchment paper, for approximately 15 to 20 minutes (250° C)."
        ]
        
        steps.enumerated().forEach { (index, step) in
            let containerView = UIView()
            containerView.translatesAutoresizingMaskIntoConstraints = false
            containerView.backgroundColor = .gray.withAlphaComponent(0.1)
            containerView.layer.cornerRadius = 17
            containerView.layer.masksToBounds = true
            containerView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            
            let boldPrefix = "Step \(index + 1) - "
            let fullText = boldPrefix + step
            
            let attributedString = NSMutableAttributedString(string: fullText)
            let boldFont = UIFont(name: "Poppins-Bold", size: 16) ?? UIFont.boldSystemFont(ofSize: 16)
            let regularFont = UIFont(name: "Poppins-Medium", size: 16) ?? UIFont.systemFont(ofSize: 16)
            
            attributedString.addAttribute(.font, value: boldFont, range: NSRange(location: 0, length: boldPrefix.count))
            attributedString.addAttribute(.font, value: regularFont, range: NSRange(location: boldPrefix.count, length: step.count))
            
            let stepLabel = UILabel()
            stepLabel.translatesAutoresizingMaskIntoConstraints = false
            stepLabel.attributedText = attributedString
            stepLabel.numberOfLines = 0
            
            containerView.addSubview(stepLabel)
            
            NSLayoutConstraint.activate([
                stepLabel.topAnchor.constraint(equalTo: containerView.layoutMarginsGuide.topAnchor),
                stepLabel.leadingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.leadingAnchor),
                stepLabel.trailingAnchor.constraint(equalTo: containerView.layoutMarginsGuide.trailingAnchor),
                stepLabel.bottomAnchor.constraint(equalTo: containerView.layoutMarginsGuide.bottomAnchor)
            ])
            
            stack.addArrangedSubview(containerView)
        }
        
        return stack
    }()
    
    // Scroll View
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        setupDismissKeyboard()
        setup()
    }
    
    private func setupDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - ViewCodeProtocol
extension CookiesModalVC: ViewCodeProtocol {
    func addSubViews() {
        // Add background image first
        view.addSubview(backgroundCookieImage)
        view.addSubview(header)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(ingredientsTitleLabel)
        contentView.addSubview(ingredientsCollectionView)
        contentView.addSubview(instructionsTitleLabel)
        contentView.addSubview(instructionsStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Background image constraints
            backgroundCookieImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundCookieImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundCookieImage.topAnchor.constraint(equalTo: view.topAnchor, constant: -150),
            backgroundCookieImage.bottomAnchor.constraint(equalTo: header.topAnchor),
            
            // Header
            header.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.heightAnchor.constraint(equalToConstant: 93),
            
            // Scroll View
            scrollView.topAnchor.constraint(equalTo: header.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Content View
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Ingredients Title
            ingredientsTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            ingredientsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            ingredientsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Ingredients Collection View
            ingredientsCollectionView.topAnchor.constraint(equalTo: ingredientsTitleLabel.bottomAnchor, constant: 12),
            ingredientsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ingredientsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            ingredientsCollectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 130),
            
            // Instructions Title
            instructionsTitleLabel.topAnchor.constraint(equalTo: ingredientsCollectionView.bottomAnchor, constant: 24),
            instructionsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            instructionsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Instructions List
            instructionsStackView.topAnchor.constraint(equalTo: instructionsTitleLabel.bottomAnchor, constant: 12),
            instructionsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            instructionsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            instructionsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
}
