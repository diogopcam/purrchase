//
//  Product.swift
//  purrchase
//
//  Created by Diogo Camargo on 14/05/25.
//
import UIKit
import Foundation

class Product: Codable {
    let id: String
    let name: String
    let category: Category
    let amount: Int
    let observation: String?
    let imageName: String?
    
    var image: UIImage? {
        guard let imageName = imageName else { return nil }
        return loadImageFromDocuments(imageName: imageName)
    }
    
    // Primary initializer (for decoding and internal use)
    init(
        id: String = UUID().uuidString,
        name: String,
        category: Category,
        amount: Int,
        observation: String? = nil,
        imageName: String? = nil
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.amount = amount
        self.observation = observation
        self.imageName = imageName
    }
    
    // Convenience initializer (for creating with UIImage)
    convenience init(
        name: String,
        category: Category,
        amount: Int,
        observation: String? = nil,
        image: UIImage?
    ) {
        let imageName = image != nil ? "product_\(UUID().uuidString).jpg" : nil
        
        self.init(
            name: name,
            category: category,
            amount: amount,
            observation: observation,
            imageName: imageName
        )
        
        if let image = image, let imageName = imageName {
            saveImageToDocuments(image: image, imageName: imageName)
        }
    }
    
    // MARK: - Image Handling
    
    private func saveImageToDocuments(image: UIImage, imageName: String) {
        guard let documentsDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else { return }
        
        let fileURL = documentsDirectory.appendingPathComponent(imageName)
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch {
            print("Error saving image: \(error.localizedDescription)")
        }
    }
    
    private func loadImageFromDocuments(imageName: String) -> UIImage? {
        guard let documentsDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else { return nil }
        
        let fileURL = documentsDirectory.appendingPathComponent(imageName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image: \(error.localizedDescription)")
            return nil
        }
    }
    
    // MARK: - Codable
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case category
        case amount
        case observation
        case imageName
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        category = try container.decode(Category.self, forKey: .category)
        amount = try container.decode(Int.self, forKey: .amount)
        observation = try container.decodeIfPresent(String.self, forKey: .observation)
        imageName = try container.decodeIfPresent(String.self, forKey: .imageName)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(category, forKey: .category)
        try container.encode(amount, forKey: .amount)
        try container.encodeIfPresent(observation, forKey: .observation)
        try container.encodeIfPresent(imageName, forKey: .imageName)
    }
}
