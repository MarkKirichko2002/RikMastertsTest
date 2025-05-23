//
//  UserTableViewCell.swift
//  RikMastersApp
//
//  Created by Марк Киричко on 20.05.2025.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    static let identifier = "UserTableViewCell"
    
    private let userImage: UIImageView = {
        let image = UIImageView()
        image.tintColor = .label
        return image
    }()
    
    private let userName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .black)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userImage)
        contentView.addSubview(userName)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(for user: User) {
        userImage.clipsToBounds = true
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.loadImage(from: user.avatarURL ?? "")
        userName.text = user.username
    }
    
    private func makeConstraints() {
        userImage.pin
            .top(10)
            .left(20)
            .width(80)
            .height(80)
        userName.pin
            .after(of: userImage).marginLeft(20)
            .vCenter(to: userImage.edge.vCenter)
            .right(10)
            .height(30)
    }
}
