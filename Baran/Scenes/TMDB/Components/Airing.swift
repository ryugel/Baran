//
//  Airing.swift
//  Baran
//
//  Created by ryugel on 03/05/2024.
//  Copyright © 2024 DeRosa. All rights reserved.
//

import SwiftUI
import NukeUI
import Nuke

struct AiringView: View {
    @EnvironmentObject private var viewModel: TMDBViewModel
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        VStack {
            VStack(spacing: 10) {
                HStack(spacing: 0) {
                    Text("On The Air")
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .background(.ultraThinMaterial, in: .buttonBorder)
                }

                GeometryReader { geo in
                    let size = geo.size

                    ScrollView(.horizontal) {
                        HStack(spacing: 5) {
                            ForEach(viewModel.airing) { airing in
                                GeometryReader { proxy in
                                    let cardSize = proxy.size

                                    let minX = min((proxy.frame(in: .global).minX - 30) * 1.4, size.width * 1.4)

                                    NavigationLink {
                                        TMDBDetailView(show: airing)
                                    } label: {
                                        LazyImage(url: URL(string: airing.imageUrl + (airing.posterPath ?? ""))) { image in
                                            if let image = image.image {
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .offset(x: -minX)
                                                    .frame(width: cardSize.width, height: cardSize.height)
                                                    .clipShape(Rectangle())
                                                    .shadow(color: .black.opacity(0.25), radius: 8, x: 5, y: 10)
                                            } else {
                                                Image(.placeholder)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .offset(x: -minX)
                                                    .frame(width: cardSize.width, height: cardSize.height)
                                                    .clipShape(Rectangle())
                                                    .shadow(color: .black.opacity(0.25), radius: 8, x: 5, y: 10)
                                            }
                                        }
                                        .processors([.resize(size: .init(width: cardSize.width, height: cardSize.height))])
                                        .priority(.veryHigh)

                                    }
                                }
                                .frame(width: size.width - 60, height: size.height - 50)
                                .scrollTransition(.animated, axis: .horizontal) { view, phase in
                                    view
                                        .scaleEffect(phase.isIdentity ? 1 : 0.95)
                                }
                            }
                        }
                        .padding(.horizontal, 30)
                        .scrollTargetLayout()
                        .frame(height: size.height, alignment: .top)
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .scrollIndicators(.hidden)
                }
                .frame(height: sizeClass == .regular ? 666 : 500)
                .padding(.horizontal, -15)
                .padding(.top, 20)
            }
            .padding(15)
        }
        .scrollIndicators(.hidden)
        .onAppear {
            viewModel.fetchTMDBData(tmdbUrl: .airing)
        }
    }
}
