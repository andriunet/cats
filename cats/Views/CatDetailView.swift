//
//  CatDetailView.swift
//  Cats
//
//  Created by Andres Marin on 16/01/25.
//

import SwiftUI

struct CatDetailView: View {
    let cat: Cat
    @State private var imageData: Data?
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                if let imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .shadow(radius: 8)
                } else {
                    Text("No image found")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2), in: RoundedRectangle(cornerRadius: 12))
                }
                
                VStack(alignment: .leading, spacing: 12) {

                    if !cat.tags.isEmpty {
                        Text("Tags")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color.purple.opacity(0.1)))

                        Text(cat.tags.joined(separator: ", "))
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3), lineWidth: 1))
                    }
                    
                    Text("Owner: \(cat.owner.isEmpty ? "Unknown" : cat.owner)")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .padding(.bottom, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 12).fill(Color.purple.opacity(0.1)))
                    
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
                .padding(.bottom, 20)
                
                Spacer()
            }
        }
        .padding()
        .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        .navigationTitle("Cat Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            if imageData == nil {
                imageData = await CatAPIService.shared.fetchCatImage(for: cat.id)
            }
        }
    }
    
    private func parseDate(from dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM dd yyyy HH:mm:ss"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: dateString)
    }
}

