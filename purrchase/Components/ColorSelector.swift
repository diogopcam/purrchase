//
//  ColorSlectoComponent.swift
//  purrchase
//
//  Created by Richard Fagundes Rodrigues on 14/05/25.
//

import UIKit

/// `ColorSelector` é uma UIView personalizada que exibe uma lista de círculos coloridos como botões.
/// Ao tocar em um círculo, ele é destacado visualmente e marcado como selecionado.
class ColorSelector: UIView {
    
    /// Lista de cores que serão usadas nos botões circulares.
    private let colorMap: [(name: String, color: UIColor)] = [
        ("Circle-1", UIColor(named: "Circle-1")!),
        ("Circle-2", UIColor(named: "Circle-2")!),
        ("Circle-3", UIColor(named: "Circle-3")!),
        ("Circle-4", UIColor(named: "Circle-4")!),
        ("Circle-5", UIColor(named: "Circle-5")!),
        ("Circle-6", UIColor(named: "Circle-6")!)
    ]
    
    /// Armazena todos os botões de cor criados para permitir controle de seleção.
    private var colorButtons: [UIButton] = []
    
    /// Referência ao botão atualmente selecionado.
    private var selectedButton: UIButton?
    
    var selectedColorName: String? {
            selectedButton?.accessibilityIdentifier
        }
    
    /// Label que exibe o título "Colors".
    lazy var namedLabel: UILabel = {
        let label = UILabel()
        label.text = "Colors"
        label.font = UIFont(name: "Poppins-Regular", size: 17)
        return label
    }()
    
    /// Stack horizontal com os círculos (botões de cor).
    private lazy var circleStack: UIStackView = {
        let buttons = colorMap.map { pair in
            return createCircle(name: pair.name, color: pair.color)
        }
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.spacing = 9
        return stack
    }()

    /// Stack principal vertical que contém o título e os botões coloridos.
    lazy var stackColorSelector: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [namedLabel, circleStack])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.layer.cornerRadius = 12
        stackView.backgroundColor = UIColor.primary.withAlphaComponent(0.5)
        stackView.spacing = 8
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 16, right: 16)
        return stackView
    }()
    
    // MARK: - Inicializadores

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Criação de Botões Circulares

    /// Cria um botão circular com uma cor específica.
    /// - Parameter color: Cor de fundo do botão.
    /// - Returns: UIButton estilizado como círculo colorido.
    private func createCircle(name: String, color: UIColor) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = color
        button.layer.cornerRadius = 21
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false

        // guarda o nome do asset
        button.accessibilityIdentifier = name

        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 42),
            button.heightAnchor.constraint(equalToConstant: 42)
        ])

        button.addTarget(self, action: #selector(circleTapped(_:)), for: .touchUpInside)
        colorButtons.append(button)
        return button
    }
    
    // MARK: - Ação de Seleção

    /// Lida com o toque em um botão de cor.
    /// Atualiza a aparência para indicar qual botão está selecionado.
    /// - Parameter sender: O botão que foi tocado.
    @objc private func circleTapped(_ sender: UIButton) {
        // limpando seleção anterior
        selectedButton?.layer.borderWidth = 1
        selectedButton?.layer.borderColor = UIColor.black.cgColor

        // destacando novo
        sender.layer.borderWidth = 3
        sender.layer.borderColor = UIColor.softGreen.cgColor

        selectedButton = sender
    }
}

// MARK: - Conformidade com ViewCodeProtocol

extension ColorSelector: ViewCodeProtocol {
    
    /// Adiciona a stack principal à hierarquia de views.
    func addSubViews() {
        addSubview(stackColorSelector)
    }
    
    /// Define as constraints da stack principal em relação à view externa.
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackColorSelector.topAnchor.constraint(equalTo: self.topAnchor),
            stackColorSelector.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackColorSelector.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackColorSelector.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
