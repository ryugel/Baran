//
//  SearchBar.swift
//  Baran
//
//  Created by ryugel on 03/05/2024.
//  Copyright © 2024 DeRosa. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    @Binding var txt: String
    var body: some View {
        HStack(spacing: 15) {
                   Image(systemName: "magnifyingglass")
                       .font(.body)
                       .foregroundColor(.white)

                   TextField("Search For Movies, Shows", text: $txt)
                .foregroundColor(.white.opacity(0.5))

               }
        .padding()
               .overlay(
                   RoundedRectangle(cornerRadius: 10)
                       .stroke(Color.white, lineWidth: 2)
               )
               .background(Color.clear)
    }
}
