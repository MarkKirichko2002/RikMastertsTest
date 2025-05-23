//
//  Statistic.swift
//  RikMastersCore
//
//  Created by Марк Киричко on 19.05.2025.
//

import Foundation

struct Statistic: Codable {
    let userId: Int
    let type: String
    let dates: [Int]
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case type
        case dates
    }
}
