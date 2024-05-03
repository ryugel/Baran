//
//  UserViewModel.swift
//  Baran
//
//  Created by ryugel on 03/05/2024.
//  Copyright © 2024 DeRosa. All rights reserved.
//

import FirebaseFirestore
import FirebaseAuth

class UserViewModel: ObservableObject {
    @Published var user: User?
    private var database = Firestore.firestore()
    func fetchUser() async {
        do {
            if let userUID = Auth.auth().currentUser?.uid {
                let documentSnapshot = try await database.collection("Users").document(userUID).getDocument()
                try await MainActor.run { [weak self] in
                    self?.user = try documentSnapshot.data(as: User.self)
                }
            }
        } catch {
            print("Error fetching user: \(error)")
        }
    }

    func addToFavorites(_ item: TMDB) {
        guard var currentUser = user else { return }
        if !currentUser.favorites.contains(where: { $0.id == item.id }) {
            currentUser.favorites.append(item)
            updateUser(currentUser)
        }
    }

    func removeFromFavorites(_ item: TMDB) {
        guard var currentUser = user else { return }
        if let index = currentUser.favorites.firstIndex(where: { $0.id == item.id }) {
            currentUser.favorites.remove(at: index)
            updateUser(currentUser)
        }
    }
    func removeAllFavorites() {
        guard let currentUser = user else { return }
        user?.favorites.removeAll()
        updateUser(user ?? currentUser)
    }

    private func updateUser(_ user: User) {
        let userID = user.userUID
        do {
            try database.collection("Users").document(userID).setData(from: user)
        } catch let error {
            print("Error updating user: \(error)")
        }
    }
}
