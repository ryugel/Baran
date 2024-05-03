//
//  LoginViewModel.swift
//  Baran
//
//  Created by ryugel on 03/05/2024.
//  Copyright © 2024 DeRosa. All rights reserved.
//

import SwiftUI
import Firebase

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showError = false
    @Published var errorMsg = ""
    @Published var isLoading = false
    @Published var createAccount = false
    @Published var alert = false
    @AppStorage("is_logged") var isLogged = false
    @AppStorage("image_URL") var imageUrl: URL?
    @AppStorage("user_pseudo") var userpseudo = ""
    @AppStorage("user_UID") var userUID = ""

    func login() {
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            self.isLoading = false
            if let error = error {
                self.errorMsg = error.localizedDescription
                self.showError = true
            } else {
                self.fetchUser()
            }
        }
    }

    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.errorMsg = error.localizedDescription
                self.showError = true
            } else {
                self.alert = true
            }
        }
    }

    private func fetchUser() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("Users").document(userID).getDocument { document, error in
            if let error = error {
                self.errorMsg = error.localizedDescription
                self.showError = true
            } else if let document = document, document.exists {
                if let user = try? document.data(as: User.self) {
                    self.userpseudo = user.username
                    self.userUID = userID
                    self.imageUrl = user.pictureURL
                    self.isLogged = true
                }
            }
        }
    }
}
