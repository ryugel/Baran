//
//  UpcomingRow.swift
//  Baran
//
//  Created by ryugel on 03/05/2024.
//  Copyright © 2024 DeRosa. All rights reserved.
//

import SwiftUI
import NukeUI

struct UpcomingRow: View {
    let tmdb: TMDB

    var body: some View {
        NavigationLink {
            TMDBDetailView(show: tmdb)
        } label: {
            HStack(alignment: .top, spacing: 10) {
                LazyImage(url: URL(string: tmdb.imageUrl + (tmdb.posterPath ?? ""))) {image in
                    if let image = image.image {
                        image
                            .resizable()
                            .frame(width: 80, height: 120)
                            .cornerRadius(8)
                    } else {
                        Image(.placeholder)
                            .resizable()
                            .frame(width: 80, height: 120)
                            .cornerRadius(8)
                    }

                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(tmdb.name ?? tmdb.originalTitle ?? tmdb.originalName ?? "Unknown")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .lineLimit(2)

                    Text("Release Date: \(tmdb.releaseDate ?? "Unknown")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Spacer()
            }
        }

    }
}
