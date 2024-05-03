//
//  LoadingView.swift
//  Baran
//
//  Created by ryugel on 03/05/2024.
//  Copyright © 2024 DeRosa. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    @Binding var showing: Bool

    var body: some View {
        ZStack {
            if showing {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                Group {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .frame(width: 120, height: 120)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .scaleEffect(1.5)
                }
            }
        }
        .animation(.easeInOut(duration: 0.25), value: showing)
    }
}
