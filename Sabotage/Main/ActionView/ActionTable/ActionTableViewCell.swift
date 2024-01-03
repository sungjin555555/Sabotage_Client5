//
//  ActionTableViewCell.swift
//  Sabotage
//
//  Created by 김하람 on 12/30/23.
//

import UIKit


class ActionTableViewCell: UITableViewCell {
    let cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .base200 // 기본 배경색
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: 테이블뷰 - cell에 들어갈 텍스트의 변수
    let textLabels: UILabel = {
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
    
    
    func configure(with text: String) {
        textLabels.text = text
    }
    
    private func setupCell() {
        contentView.addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(textLabels) // Add textLabel to cellBackgroundView

        NSLayoutConstraint.activate([
            cellBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cellBackgroundView.heightAnchor.constraint(equalToConstant: 100),
            
            textLabels.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 10),
            textLabels.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 10),
            textLabels.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -10),
            textLabels.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor, constant: -10)
        ])
    }
}
