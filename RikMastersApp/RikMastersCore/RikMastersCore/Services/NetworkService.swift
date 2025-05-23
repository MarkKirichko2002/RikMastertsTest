//
//  NetworkService.swift
//  RikMastersCore
//
//  Created by Марк Киричко on 19.05.2025.
//

import Foundation

class NetworkService {
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        let url = URL(string: "http://test.rikmasters.ru/api/users/")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            do {
                let response = try JSONDecoder().decode(UsersResponse.self, from: data)
                completion(.success(response.users))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchStatistics(completion: @escaping (Result<[Statistic], Error>) -> Void) {
        let url = URL(string: "http://test.rikmasters.ru/api/statistics/")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            do {
                let response = try JSONDecoder().decode(StatisticsResponse.self, from: data)
                completion(.success(response.statistics))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
