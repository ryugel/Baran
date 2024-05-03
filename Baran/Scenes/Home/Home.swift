//
//  Home.swift
//  Baran
//
//  Created by ryugel on 03/05/2024.
//  Copyright © 2024 DeRosa. All rights reserved.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject private var viewModel: TMDBViewModel
    var body: some View {
        VStack {
            ScrollView {
                AiringView()
                    .environmentObject(viewModel)
                VStack(alignment: .leading) {
                    Text("Popular")
                        .bold()
                        .font(.headline)
                        .padding(.leading)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.popular, id: \.self) {top in
                                TMDBCard(tmdb: top)
                            }
                        }
                    }
                    Text("Top rated")
                        .bold()
                        .font(.headline)
                        .padding(.leading)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.topRated, id: \.self) {top in
                                TMDBCard(tmdb: top)
                            }
                        }
                    }
                    Text("Upcoming")
                        .bold()
                        .font(.headline)
                        .padding(.leading)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.upcoming, id: \.self) {upcoming in
                                TMDBCard(tmdb: upcoming)
                            }
                        }
                    }
                    Text("Trendings")
                        .bold()
                        .font(.headline)
                        .padding(.leading)
                    trending
                } }

            .scrollIndicators(.hidden)
            .task {
                viewModel.fetchTMDBData(tmdbUrl: .popular)
                viewModel.fetchTMDBData(tmdbUrl: .topRated)
                viewModel.fetchTMDBData(tmdbUrl: .upcoming)
                viewModel.fetchTMDBData(tmdbUrl: .trending)
            }
        }
    }
    var trending: some View {
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.trendings) {trend in
                    TMDBCard(tmdb: trend)
                }
            }
        }
    }
}

#Preview {
    Home()
}
