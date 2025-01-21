//
//  CatListView.swift
//  cats
//
//  Created by Andres Marin on 16/01/25.
//
import SwiftUI
import SwiftUI

struct CatListView: View {
    @StateObject private var viewModel = CatListViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.cats.isEmpty {
                    ProgressView("Loading cats...")
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.purple))
                        .scaleEffect(2)
                        .padding()
                        .background(Color.white.opacity(0.8), in: RoundedRectangle(cornerRadius: 16))
                        .shadow(radius: 10)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(viewModel.cats, id: \.id) { cat in
                                NavigationLink(destination: CatDetailView(cat: cat)) {
                                    CatRowView(cat: cat)
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
                withAnimation {
                    viewModel.loadCats()
                }
            }
        }
    }
}

struct CatRowView: View {
    let cat: Cat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.1), Color.blue.opacity(0.1)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)

            HStack {
                if let imageURL = CatAPIService.shared.fetchCatImageURL(for: cat.id) {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 80, height: 80)
                                .background(Circle().fill(Color.gray.opacity(0.2)))
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                .shadow(radius: 4)
                        case .failure:
                            Image(systemName: "photo")
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(Circle())
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "photo")
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(cat.tags.first ?? "Unknown")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .fontWeight(.bold)
                    
                    Text(cat.owner.isEmpty ? "Owner: Unknown" : "Owner: \(cat.owner)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                        .truncationMode(.tail)
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
