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
    
    private init() {}
    
    func fetchCatImageURL(for id: String) -> URL? {
        return URL(string: "\(baseURL)/cat/\(id)")
    }
}
