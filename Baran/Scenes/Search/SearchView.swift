//
//  SearchView.swift
//  Baran
//
//  Created by ryugel on 03/05/2024.
//  Copyright © 2024 DeRosa. All rights reserved.
//

import SwiftUI
import NukeUI
import Nuke

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        NavigationStack {
            SearchBar(txt: $viewModel.searchText)
                .padding()
            if viewModel.searchText.isEmpty {
                ContentUnavailableView("Search", systemImage: "magnifyingglass", description: Text("Are you looking for something ?"))
            } else {
                ScrollView {
                    LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 20), count: sizeClass == .regular ? 4:3), spacing: 10) {
                        ForEach(viewModel.searchedMovies) { movie in
                            NavigationLink {
                                TMDBDetailView(show: movie)
                            } label: {
                                MovieItemView(movie: movie)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarItems(leading: SearchBar(txt: $viewModel.searchText))
        .onAppear {
            viewModel.searchTMDB()
        }
    }
}
struct MovieItemView: View {
    let movie: TMDB
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        VStack {
            LazyImage(url: URL(string: movie.imageUrl + (movie.posterPath ?? movie.backdropPath ?? ""))) { image in
                if let image = image.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: sizeClass == .regular ? 300 : 100, height: sizeClass == .regular ? 425 : 150)
                        .cornerRadius(10)
                } else {
                    Image(.placeholder)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: sizeClass == .regular ? 300 : 100, height: sizeClass == .regular ? 225 : 150)
                        .cornerRadius(10)
                }
            }
            .processors([.resize(size: .init(width: sizeClass == .regular ? 300 : 100, height: sizeClass == .regular ? 425 : 150))])
        }
    }
}
