//
//  RealmStatistic.swift
//  RikMastersApp
//
//  Created by Марк Киричко on 20.05.2025.
//

import RealmSwift
import Foundation

class RealmStatistic: Object {
    @objc dynamic var userId: Int = 0
    @objc dynamic var type: String = ""
    let dates = List<String>()
}
