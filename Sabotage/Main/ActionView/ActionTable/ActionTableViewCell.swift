//
//  ActionTableViewCell.swift
//  Sabotage
//
//  Created by 김하람 on 12/30/23.
//

import UIKit

//class ActionTableViewCell: UICollectionViewCell {
//
//    var nameLabel: UILabel!
//    var images: UIImageView!
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setUi()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setUi() {
//        nameLabel = UILabel()
//        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//        nameLabel.textColor = .blue
//        images = UIImageView()
//        images.contentMode = .scaleAspectFit
//
//        contentView.addSubview(nameLabel)
//        contentView.addSubview(images)
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        images.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 0),
//            images.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 30),
//            images.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            images.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            images.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
//        ])
//
//    }
//}


class ActionTableViewCell: UITableViewCell {
    //    // Your cell UI components
    //    let cellImageView = UIImageView()
    //
    //    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    //        super.init(style: style, reuseIdentifier: reuseIdentifier)
    //        setupCell()
    //    }
    //
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    //
    //    private func setupCell() {
    //        // Configure your cell UI here
    //        cellImageView.contentMode = .scaleAspectFit
    //        contentView.backgroundColor = .base50 // 또는 원하는 다른 UIColor
    //        contentView.addSubview(cellImageView)
    //
    //        // Set constraints for the image view
    //        cellImageView.translatesAutoresizingMaskIntoConstraints = false
    //        NSLayoutConstraint.activate([
    //            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
    //            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
    //            cellImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
    //            cellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
    //        ])
    //    }
    //
    //    func configure(with label: String) {
    //        // Configure cell with data
    //        cellImageView.image = UIImage(named: imageName)
    //    }
    //
    //
    var categoryLabel: UILabel!
    var contentLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        categoryLabel = UILabel()
        categoryLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        categoryLabel.textColor = .blue
        
        contentView.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        contentLabel.textColor = .blue
        
        contentView.addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            categoryLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 0),
            contentLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contentLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 30)

        ])
        func configure(with category: String, content: String) {
            // Configure cell with data
            categoryLabel.text = category
            contentLabel.text = content
            
        }
    }
}
