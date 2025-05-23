//
//  User.swift
//  RikMastersCore
//
//  Created by Марк Киричко on 19.05.2025.
//

import Foundation

struct User: Codable {
    let id: Int
    let sex: String
    let username: String
    let isOnline: Bool
    let age: Int
    let files: [File]
    
    var avatarURL: String? {
        files.first(where: { $0.type == "avatar" })?.url
    }
}
