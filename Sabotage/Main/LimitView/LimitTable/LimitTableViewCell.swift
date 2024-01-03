import UIKit

class LimitTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let cellImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        // titleLabel 설정
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = .black
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = .base50
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        // cellImageView 설정
        cellImageView.contentMode = .scaleAspectFit
        contentView.addSubview(cellImageView)
        cellImageView.translatesAutoresizingMaskIntoConstraints = false

        // Auto Layout 제약 조건 설정
        NSLayoutConstraint.activate([
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cellImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellImageView.widthAnchor.constraint(equalToConstant: 350),
            cellImageView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }

    func configure(with imageName: String, title: String) {
        cellImageView.image = UIImage(named: imageName)
        titleLabel.text = title
    }
}
