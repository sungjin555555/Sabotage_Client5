//
//  ActionTableViewCell.swift
//  Sabotage
//
//  Created by 김하람 on 12/30/23.
//

import UIKit

class ActionTableViewCell: UITableViewCell {
    // Your cell UI components
    let cellImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        // Configure your cell UI here
        cellImageView.contentMode = .scaleAspectFit
        contentView.backgroundColor = .base50 // 또는 원하는 다른 UIColor
        contentView.addSubview(cellImageView)

        // Set constraints for the image view
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            cellImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            cellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
        ])
    }

    func configure(with imageName: String) {
        // Configure cell with data
        cellImageView.image = UIImage(named: imageName)
    }
}

