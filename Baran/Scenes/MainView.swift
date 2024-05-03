//
//  MainView.swift
//  Baran
//
//  Created by ryugel on 03/05/2024.
//  Copyright © 2024 DeRosa. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @State var myProfile: User?
    @AppStorage("is_logged") var isLogged = false

    @StateObject private var viewModel = TMDBViewModel()
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        if isLogged {
            HomeView()
                .environmentObject(viewModel)
        } else {
           LoginView()
        }
    }
}
