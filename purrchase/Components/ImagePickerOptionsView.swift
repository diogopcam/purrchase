//
//  ImagePickerOptionsView.swift
//  purrchase
//
//  Created by Diogo Camargo on 15/05/25.
//


import UIKit

class ImagePickerOptionsView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var options: [(title: String, icon: UIImage?)] = [
        ("Take", UIImage(systemName: "photo")?.withTintColor(.softGreen, renderingMode: .alwaysOriginal)),
        ("Choose", UIImage(systemName: "camera")?.withTintColor(.softGreen, renderingMode: .alwaysOriginal)),
        ("Our library", UIImage(systemName: "book")?.withTintColor(.softGreen, renderingMode: .alwaysOriginal))
    ]
    
    var onSelect: ((Int) -> Void)?
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isScrollEnabled = false
        table.layer.cornerRadius = 10
        table.clipsToBounds = true
        table.separatorInset = .zero
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 6
        layer.shadowOffset = .zero
        layer.cornerRadius = 10
        
        addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomCenteredCell.self, forCellReuseIdentifier: "cell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(options.count * 50))
        ])
    }
    
    // MARK: - UITableView Data Source & Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomCenteredCell else {
            return UITableViewCell()
        }
        
        let option = options[indexPath.row]
        cell.titleLabel.text = option.title
        cell.iconImageView.image = option.icon?.withRenderingMode(.alwaysTemplate)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelect?(indexPath.row)
        removeFromSuperview()
    }
}
