//
//  User.swift
//  Baran
//
//  Created by ryugel on 03/05/2024.
//  Copyright © 2024 DeRosa. All rights reserved.
//

import SwiftUI
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var userUID: String
    var username: String
    var email: String
    var pictureURL: URL
    var password: String
    var favorites: [TMDB]

    enum CodingKeys: CodingKey {
    case id
    case userUID
    case username
    case email
    case pictureURL
    case password
    case favorites
    }

}
