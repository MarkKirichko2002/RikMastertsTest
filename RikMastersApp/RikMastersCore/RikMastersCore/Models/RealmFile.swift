//
//  RealmFile.swift
//  RikMastersApp
//
//  Created by Марк Киричко on 20.05.2025.
//

import RealmSwift
import Foundation

class RealmFile: Object {
    @objc dynamic var url: String = ""
    @objc dynamic var type: String = ""
}
