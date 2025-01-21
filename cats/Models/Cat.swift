//
//  Cat.swift
//  Cats
//
//  Created by Andres Marin on 16/01/25.
//

struct Cat: Identifiable, Codable {
    let id: String
    let tags: [String]
    let owner: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case tags, owner, createdAt, updatedAt
    }
}
