//
//  TMDBCard.swift
//  Baran
//
//  Created by ryugel on 03/05/2024.
//  Copyright © 2024 DeRosa. All rights reserved.
//

import SwiftUI
import NukeUI
import Nuke

struct TMDBCard: View {
    let tmdb: TMDB

    var body: some View {
        NavigationLink {
            TMDBDetailView(show: tmdb)
        } label: {
            VStack {
                LazyImage(url: URL(string: tmdb.imageUrl + (tmdb.posterPath ?? ""))) {image in

                    if let image = image.image {
                        image
                            .resizable()
                            .frame(width: 80, height: 95)
                    } else {
                        Image(.placeholder)
                            .resizable()
                            .frame(width: 80, height: 95)
                    }

                }

                .processors([.resize(size: .init(width: 80, height: 95))])
                .priority(.veryHigh)
            }
        }

    }
}
