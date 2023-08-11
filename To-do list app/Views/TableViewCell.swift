//
//  TableViewCell.swift
//  To-do list app
//
//  Created by ZhZinekenov on 09.08.2023.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    static let identifier = "CustomTableViewCell"

    let titleLabel = UILabel()
    let descriptionLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.font = .italicSystemFont(ofSize: 11)
        titleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        accessoryType = .checkmark

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }

    func setup(task: Task) {
        titleLabel.text = task.finalTitle
        descriptionLabel.text = task.timeUpdated
        if task.completed {
            accessoryType = .checkmark
        } else {
            accessoryType = .none
        }
    }
}

