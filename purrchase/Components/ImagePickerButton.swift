//
//  ImagePicker.swift
//  purrchase
//
//  Created by Diogo Camargo on 15/05/25.
//

import UIKit

class ImagePickerButton: UIButton {
    
    lazy var optionsTableView: ImagePickerOptionsView = {
        var options = ImagePickerOptionsView()
        return options
    }()
    
    // MARK: - Inicialização
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Apresentação do Action Sheet
    private weak var presentingController: UIViewController?
    
    func configure(presentingController: UIViewController) {
        self.presentingController = presentingController
    }
}

// MARK: - ViewCodeProtocol
extension ImagePickerButton: ViewCodeProtocol {
    
    func addSubViews() {
        // Não há subviews adicionais — a própria classe é o botão
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 78.21),
            self.heightAnchor.constraint(equalToConstant: 78)
        ])
    }
    
    func setup() {
        let cameraImage = UIImage(systemName: "camera.fill")
        self.setImage(cameraImage, for: .normal)
        self.tintColor = .tertiary
        self.backgroundColor = .backgroundYellow
        self.imageView?.contentMode = .scaleAspectFit
        self.contentHorizontalAlignment = .center
        self.contentVerticalAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 24
        self.clipsToBounds = true

        addSubViews()
        setupConstraints()
    }
}
