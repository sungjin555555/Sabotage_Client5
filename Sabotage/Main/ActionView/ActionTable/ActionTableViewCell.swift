//
//  ActionTableViewCell.swift
//  Sabotage
//
//  Created by 김하람 on 12/30/23.
//

import UIKit

class ActionTableViewCell: UITableViewCell {
    
    var categoryLabel: UILabel!
    var contentLabel: UILabel!
    
    let cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white // 기본 배경색
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var categoryType: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        
        contentView.backgroundColor = .base50
        contentView.addSubview(cellBackgroundView)
        
        categoryType = UILabel()
        categoryType.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        categoryType.textColor = .blue
        contentView.addSubview(categoryType)
        categoryType.translatesAutoresizingMaskIntoConstraints = false
        
        contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        contentLabel.textColor = .blue
        contentView.addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            cellBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cellBackgroundView.heightAnchor.constraint(equalToConstant: 100),
            
            categoryType.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            categoryType.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 0),
            categoryType.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            categoryType.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 30)

        ])
        func configure(with category: String, content: String) {
            // Configure cell with data
            categoryLabel.text = category
            contentLabel.text = content
            
        }
    }
}
