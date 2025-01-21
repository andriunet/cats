//
//  CatListViewModel.swift
//  Cats
//
//  Created by Andres Marin on 16/01/25.
//

import Foundation

class CatListViewModel: ObservableObject {
    @Published var cats: [Cat] = []
    @Published var errorMessage: String?

    init() {
        loadCats()
    }
    
    func loadCats() {
        guard let url = Bundle.main.url(forResource: "Cats", withExtension: "json") else {
            errorMessage = "No se encontró el archivo Cats.json."
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            cats = try decoder.decode([Cat].self, from: data)
        } catch {
            errorMessage = "Error al cargar los datos: \(error.localizedDescription)"
        }
    }
}
