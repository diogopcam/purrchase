//
//  ProductStorageService.swift
//  purrchase
//
//  Created by Diogo Camargo on 20/05/25.
//
import UIKit

class ProductStorageService {
    static let shared = ProductStorageService()
    private init() {}

    private let fileManager = FileManager.default

    /// Caminho para a pasta de imagens dos produtos
    private var imagesDirectoryURL: URL {
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let imagesURL = documentsURL.appendingPathComponent("ProductImages")

        // Cria a pasta se não existir
        if !fileManager.fileExists(atPath: imagesURL.path) {
            do {
                try fileManager.createDirectory(at: imagesURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Erro ao criar diretório de imagens: \(error)")
            }
        }

        return imagesURL
    }

    // MARK: - Save

    func saveImage(_ image: UIImage) -> String? {
        // Gera um nome único automaticamente
        let imageName = "product_\(UUID().uuidString).jpg"
        let imageURL = imagesDirectoryURL.appendingPathComponent(imageName)
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Erro ao converter imagem para JPEG")
            return nil
        }
        
        do {
            try imageData.write(to: imageURL)
            print("Imagem salva em: \(imageURL.path)")
            return imageName
        } catch {
            print("Erro ao salvar imagem: \(error)")
            return nil
        }
    }
    // MARK: - Load

    func loadImage(named imageName: String) -> UIImage? {
        let imageURL = imagesDirectoryURL.appendingPathComponent(imageName)
        return UIImage(contentsOfFile: imageURL.path)
    }

    // MARK: - Delete

    func deleteImage(named imageName: String) {
        let imageURL = imagesDirectoryURL.appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imageURL.path) {
            do {
                try fileManager.removeItem(at: imageURL)
            } catch {
                print("Erro ao deletar imagem: \(error)")
            }
        }
    }
    
    func listStoredImages() {
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: imagesDirectoryURL, includingPropertiesForKeys: nil)
            print("Imagens armazenadas no diretório:")
            for url in fileURLs {
                print("- \(url.lastPathComponent)")
            }
        } catch {
            print("Erro ao listar imagens armazenadas: \(error)")
        }
    }
}
