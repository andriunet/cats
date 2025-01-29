//
//  CatAPIService.swift
//  Cats
//
//  Created by Andres Marin on 16/01/25.
//

import Foundation

class CatAPIService {
    static let shared = CatAPIService()
    private let baseURL = "https://cataas.com"
    private let imageCache = NSCache<NSString, NSData>()
    private let timeoutInterval: TimeInterval = 5
    
    private init() {}

    func fetchCatImageURL(for id: String) -> URL? {
        return URL(string: "\(baseURL)/cat/\(id)")
    }
    
    func fetchCatImage(for id: String) async -> Data? {
        let cacheKey = id as NSString
        
        if let cachedData = imageCache.object(forKey: cacheKey) {
            return cachedData as Data
        }
        
        guard let url = fetchCatImageURL(for: id) else { return nil }
        
        let request = URLRequest(url: url, timeoutInterval: timeoutInterval)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            imageCache.setObject(data as NSData, forKey: cacheKey)
            return data
        } catch {
            print("Error descargando la imagen: \(error.localizedDescription)")
            return nil
        }
    }
}
