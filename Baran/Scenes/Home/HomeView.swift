//
//  HomeView.swift
//  Baran
//
//  Created by ryugel on 03/05/2024.
//  Copyright © 2024 DeRosa. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import NukeUI
import Nuke

struct HomeView: View {
    @State  var myProfile: User?
    @EnvironmentObject private var viewModel: TMDBViewModel

    var body: some View {
        NavigationStack {
            TabView {
                Home()
                    .tabItem {
                        Image(systemName: "house")
                    }
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                UpcomingView()
                    .environmentObject(viewModel)
                    .tabItem {
                        Image(systemName: "clock.fill")

                    }
                FavoritesView()
                    .tabItem {
                        Image(systemName: "heart")
                    }
            } .task {
                do {
                    await getUser()
                }
            }
            .navigationBarItems(leading:
                                    HStack {
                Text("Baran")
                    .font(.largeTitle).bold()
                    .foregroundColor(Color.color1)
                    .padding(.leading, 13)

                HStack {

                    NavigationLink {
                        myProfile.map { ProfileView(myProfile: $0) }
                    } label: {
                        LazyImage(url: myProfile?.pictureURL) {image in
                            image.image?
                                .resizable()
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .padding(.leading, 153)

                        }
                    }
                }

            }
            )
        }
    }

    func getUser() async {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        guard let user = try? await Firestore.firestore().collection("Users").document(userUID).getDocument(as: User.self) else { return }
        await MainActor.run {
            myProfile = user
        }
    }
}
