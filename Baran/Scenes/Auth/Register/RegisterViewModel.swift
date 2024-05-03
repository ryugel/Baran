//
//  RegisterViewModel.swift
//  Baran
//
//  Created by ryugel on 03/05/2024.
//  Copyright © 2024 DeRosa. All rights reserved.
//

import Foundation
import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage

class RegisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var password2: String = ""
    @Published var profilePic: Data?
    @Published var showError = false
    @Published var errorMsg = ""
    @Published var isLoading = false
    @Published var showImagePicker = false
    @Published var photoItem: PhotosPickerItem?
    @AppStorage("is_logged") var isLogged = false
    @AppStorage("image_URL") var imageUrl: URL?
    @AppStorage("user_pseudo") var userpseudo = ""
    @AppStorage("user_UID") var userUID = ""

    func condition() -> Bool {
           return userName.isEmpty || email.isEmpty || password.isEmpty || password != password2 || password.count <= 8 || profilePic == nil
       }

    func registerAccount() {
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error = error {
                self.errorMsg = error.localizedDescription
                self.showError = true
                self.isLoading = false
                return
            }

            guard let userID = Auth.auth().currentUser?.uid else { return }
            guard let imageData = self.profilePic else { return }

            let storageRef = Storage.storage().reference().child("Profile_Images").child(userID)
            _ = storageRef.putData(imageData, metadata: nil) { _, error in
                if let error = error {
                    self.errorMsg = error.localizedDescription
                    self.showError = true
                    self.isLoading = false
                    return
                }

                storageRef.downloadURL { url, error in
                    if let error = error {
                        self.errorMsg = error.localizedDescription
                        self.showError = true
                        self.isLoading = false
                        return
                    }

                    guard let downloadUrl = url else {
                        self.errorMsg = "Failed to get download URL."
                        self.showError = true
                        self.isLoading = false
                        return
                    }

                    let user = User(userUID: userID, username: self.userName, email: self.email, pictureURL: downloadUrl, password: self.password, favorites: [])

                    try? Firestore.firestore().collection("Users").document(userID).setData(from: user) { error in
                        if let error = error {
                            self.errorMsg = error.localizedDescription
                            self.showError = true
                            self.isLoading = false
                            return
                        }

                        self.userpseudo = self.userName
                        self.userUID = userID
                        self.imageUrl = downloadUrl
                        self.isLogged = true
                        self.isLoading = false
                    }
                }
            }
        }
    }
}
