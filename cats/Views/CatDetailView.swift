//
//  CatDetailView.swift
//  Cats
//
//  Created by Andres Marin on 16/01/25.
//

import SwiftUI

struct CatDetailView: View {
    let cat: Cat
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                if let imageURL = CatAPIService.shared.fetchCatImageURL(for: cat.id) {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 300, height: 300)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(12)
                                .padding()
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .foregroundColor(.gray)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Text("No image available")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
                
                VStack(alignment: .leading, spacing: 8) {
 
                    if !cat.tags.isEmpty {
                        Text("Tags:")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(cat.tags.joined(separator: ", "))
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Text("Owner: \(cat.owner.isEmpty ? "Unknown" : cat.owner)")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    
                    if let createdDate = parseDate(from: cat.createdAt) {
                        Text("Created At: \(dateFormatter.string(from: createdDate))")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    if let updatedDate = parseDate(from: cat.updatedAt) {
                        Text("Updated At: \(dateFormatter.string(from: updatedDate))")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .padding()
        .navigationTitle("Cat Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func parseDate(from dateString: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: dateString)
    }
}
