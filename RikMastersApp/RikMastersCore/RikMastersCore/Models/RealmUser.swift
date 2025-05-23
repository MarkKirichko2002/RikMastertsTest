//
//  RealmUser.swift
//  RikMastersApp
//
//  Created by Марк Киричко on 20.05.2025.
//

import RealmSwift
import Foundation

class RealmUser: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var sex: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var isOnline: Bool = false
    @objc dynamic var age: Int = 0
    let files = List<RealmFile>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
