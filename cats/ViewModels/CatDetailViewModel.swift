//
//  CatDetailViewModel.swift
//  Cats
//
//  Created by Andres Marin on 16/01/25.
//


import Foundation

class CatDetailViewModel: ObservableObject {
    @Published var cat: Cat?
    @Published var imageURL: URL?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let catAPIService = CatAPIService.shared
    
    init(cat: Cat) {
        self.cat = cat
        self.imageURL = catAPIService.fetchCatImageURL(for: cat.id)
    }
       
}
