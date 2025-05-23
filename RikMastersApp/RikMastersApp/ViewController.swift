//
//  ViewController.swift
//  RikMastersApp
//
//  Created by Марк Киричко on 19.05.2025.
//

import UIKit
import PinLayout
import RxSwift
import RikMastersCore

class StatisticsViewController: UIViewController {
    
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let disposeBag = DisposeBag()
    
    private let networkService = NetworkService()
    private let databaseService = DatabaseService()
    private var users: [User] = []
    private var statistics: [Statistic] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Статистика"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshControl
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        view.addSubview(tableView)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin.all()
    }
    
    private func loadData() {
        
        let cachedUsers = databaseService.getUsers()
        let cachedStats = databaseService.getStatistics()
        
        if !cachedUsers.isEmpty && !cachedStats.isEmpty {
            self.users = cachedUsers
            self.statistics = cachedStats
            tableView.reloadData()
        } else {
            fetchData()
        }
    }
    
    @objc private func refreshData() {
        fetchData()
    }
    
    private func fetchData() {
        Observable.zip(
            Observable.create { observer in
                self.networkService.fetchUsers { result in
                    switch result {
                    case .success(let users):
                        observer.onNext(users)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
                return Disposables.create()
            },
            Observable.create { observer in
                self.networkService.fetchStatistics { result in
                    switch result {
                    case .success(let stats):
                        observer.onNext(stats)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
                return Disposables.create()
            }
        )
        .subscribe(onNext: { users, stats in
            self.databaseService.saveUsers(users)
            self.databaseService.saveStatistics(stats)
            self.users = users
            self.statistics = stats
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }, onError: { error in
            print(error)
            self.refreshControl.endRefreshing()
        })
        .disposed(by: disposeBag)
    }
}

extension StatisticsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Посетители"
        case 1:
            return "Чаще всего посещают Ваш профиль"
        case 2:
            return "Пол и возраст"
        case 3:
            return "Наблюдатели"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 0
        case 1:
            return users.count
        case 2:
            return 0
        case 3:
            return 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)-> CGFloat {
        if indexPath.section == 1 {
            return 100
        } else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return UITableViewCell()
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else {return UITableViewCell()}
            cell.configure(for: users[indexPath.row])
            return cell
        case 2:
            return UITableViewCell()
        case 3:
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}
