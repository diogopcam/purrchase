//
//  ImagePickerOptionsView.swift
//  purrchase
//
//  Created by Diogo Camargo on 15/05/25.
//
import UIKit

class ImagePickerOptionsView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var options: [(title: String, icon: UIImage?)] = [
        ("Take", UIImage(systemName: "camera.fill")?.withTintColor(.softGreen, renderingMode: .alwaysOriginal)),
        ("Choose", UIImage(systemName: "photo.fill")?.withTintColor(.softGreen, renderingMode: .alwaysOriginal)),
        ("Our library", UIImage(systemName: "book.fill")?.withTintColor(.softGreen, renderingMode: .alwaysOriginal))
    ]
    
    var onSelect: ((Int) -> Void)?
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isScrollEnabled = false
        table.layer.cornerRadius = 10
        table.clipsToBounds = true
        table.separatorInset = .zero
        table.backgroundColor = .backgroundWhite
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4

        let totalHeight = CGFloat(options.count) * 54
        
        addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false // <-- ESSENCIAL!
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomCenteredCell.self, forCellReuseIdentifier: "cell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.heightAnchor.constraint(equalToConstant: totalHeight),
            tableView.widthAnchor.constraint(equalToConstant: 168),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        cell.iconImageView.tintColor = .softGreen
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onSelect?(indexPath.row)
        removeFromSuperview()
    }
}
