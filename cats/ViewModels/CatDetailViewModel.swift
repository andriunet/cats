//
//  CatDetailViewModel.swift
//  Cats
//
//  Created by Andres Marin on 16/01/25.
//


import Foundation

@MainActor
class CatDetailViewModel: ObservableObject {
    @Published var cat: Cat?
    @Published var imageData: Data?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let catAPIService = CatAPIService.shared
    
    init(cat: Cat) {
        self.cat = cat
        Task { await loadCatImage(for: cat.id) }
    }
    
    func loadCatImage(for id: String) async {
        isLoading = true
        errorMessage = nil
        
        if let data = await catAPIService.fetchCatImage(for: id) {
            self.imageData = data
        } else {
            self.errorMessage = "No se pudo cargar la imagen."
        }
        
        isLoading = false
    }
}

