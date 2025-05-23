//
//  DataManager.swift
//  RikMastersCore
//
//  Created by Марк Киричко on 19.05.2025.
//

import Foundation
import RealmSwift

class DatabaseService {
    
    private let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    func saveUsers(_ users: [User]) {
        let realmUsers = users.map { user in
            let realmUser = RealmUser()
            realmUser.id = user.id
            realmUser.sex = user.sex
            realmUser.username = user.username
            realmUser.isOnline = user.isOnline
            realmUser.age = user.age
            if let avatarURL = user.avatarURL {
                let file = RealmFile()
                file.url = avatarURL
                file.type = "avatar"
                realmUser.files.append(file)
            }
            return realmUser
        }
        
        DispatchQueue.main.async {
            try! self.realm.write {
                self.realm.delete(self.realm.objects(RealmUser.self))
                self.realm.add(realmUsers)
            }
        }
    }
    
    func saveStatistics(_ statistics: [Statistic]) {
        let realmStatistics = statistics.map { stat in
            let realmStat = RealmStatistic()
            realmStat.userId = stat.userId
            realmStat.type = stat.type
            realmStat.dates.append(objectsIn: stat.dates.map { String($0) })
            return realmStat
        }
        
        DispatchQueue.main.async {
            try! self.realm.write {
                self.realm.delete(self.realm.objects(RealmStatistic.self))
                self.realm.add(realmStatistics)
            }
        }
    }
    
    func getUsers() -> [User] {
        let realmUsers = realm.objects(RealmUser.self)
        return realmUsers.map { realmUser in
            User(
                id: realmUser.id,
                sex: realmUser.sex,
                username: realmUser.username,
                isOnline: realmUser.isOnline,
                age: realmUser.age,
                files: realmUser.files.map { File(id: 0, url: $0.url, type: $0.type) }
            )
        }
    }
    
    func getStatistics() -> [Statistic] {
        let realmStats = realm.objects(RealmStatistic.self)
        return realmStats.map { realmStat in
            Statistic(
                userId: realmStat.userId,
                type: realmStat.type,
                dates: realmStat.dates.map { Int($0) ?? 0 }
            )
        }
    }
}
