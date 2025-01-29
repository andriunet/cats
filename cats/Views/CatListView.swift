//
//  CatListView.swift
//  cats
//
//  Created by Andres Marin on 16/01/25.
//

import SwiftUI

struct CatListView: View {
    @StateObject private var viewModel = CatListViewModel()
    @State private var searchText = ""
    @State private var isLoading = true

    var filteredCats: [Cat] {
        if searchText.isEmpty {
            return viewModel.cats
        } else {
            return viewModel.cats.filter { cat in
                cat.tags.joined(separator: " ").localizedCaseInsensitiveContains(searchText) ||
                (!cat.owner.isEmpty && cat.owner.localizedCaseInsensitiveContains(searchText))
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $searchText)
                    .padding(.top, 10) 
                if isLoading {
                    ProgressView("Loading cats...")
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.purple))
                        .scaleEffect(2)
                        .padding()
                        .background(Color.white.opacity(0.8), in: RoundedRectangle(cornerRadius: 16))
                        .shadow(radius: 10)
                } else if filteredCats.isEmpty {
                    Text("No cats found")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(filteredCats, id: \.id) { cat in
                                NavigationLink(destination: CatDetailView(cat: cat)) {
                                    CatRowView(viewModel: viewModel, cat: cat)
                                }
                                .transition(.scale)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                    .transition(.move(edge: .top))
                }
            }
            .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
            .navigationTitle("Cats Gallery")
            .onAppear {
                Task {
                    viewModel.loadCats()
                    isLoading = false
                }
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search cats...", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        if !text.isEmpty {
                            Button(action: { text = "" }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
        }
    }
}

struct CatRowView: View {
    let viewModel: CatListViewModel
    let cat: Cat
    @State private var imageData: Data?

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.1), Color.blue.opacity(0.1)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)

            HStack {
                if let imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 3))
                        .shadow(radius: 4)
                } else {
                    Image(systemName: "photo")
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 3))
                        .shadow(radius: 4)
                        .foregroundColor(.gray)
                        .background(Circle().fill(Color.gray.opacity(0.2)))
                }

                VStack(alignment: .leading, spacing: 8) {
                    if let firstTag = cat.tags.first, !firstTag.isEmpty {
                        Text(firstTag)
                            .font(.headline)
                            .foregroundColor(.primary)
                            .fontWeight(.bold)
                    }

                    if !cat.owner.isEmpty {
                        Text("Owner: \(cat.owner)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                }
                .padding(.leading, 12)

                Spacer()
            }
            .padding()
        }
        .frame(height: 120)
        .padding(.horizontal)
        .background(RoundedRectangle(cornerRadius: 16).stroke(Color.white, lineWidth: 2))
        .padding(.vertical, 4)
        .task {
            if imageData == nil {
                imageData = await viewModel.fetchImage(for: cat.id)
            }
        }
    }
}


// Previsualización
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CatListView()
    }
}

#Preview {
    CatListView()
}
