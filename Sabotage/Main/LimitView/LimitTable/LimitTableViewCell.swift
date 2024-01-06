// LimitTableViewCell




import UIKit

class LimitTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let timeBudget = UILabel()
    let nextImageView = UIImageView()
    let appImage = UIImageView()
    let appImage1 = UIImageView()
    let appImage2 = UIImageView()
    let appImage3 = UIImageView()

    let cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, timeBudget: Int) {
        titleLabel.text = title
        let hours = timeBudget / 60
        let minutes = timeBudget % 60
        if(hours == 0) {
            self.timeBudget.text = "\(minutes*3)분 중 \(minutes-1)분 사용"
        } else {
            self.timeBudget.text = "\(hours)시간 \(minutes)분 중 1분 사용"
        }
        if(minutes == 0) {
            self.timeBudget.text = "\(hours)시간 중 1분 사용"
        }
    }
    
    private func setupLayout() {
        
        contentView.backgroundColor = .base50
        contentView.addSubview(cellBackgroundView)
        
        // titleLabel 설정
        titleLabel.font = UIFont.Callout()
        titleLabel.textColor = .base700
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // timeBudget 설정
        timeBudget.font = UIFont.Headline()
        timeBudget.textColor = .base500
        contentView.addSubview(timeBudget)
        timeBudget.translatesAutoresizingMaskIntoConstraints = false
        
        // Auto Layout 제약 조건 설정
        NSLayoutConstraint.activate([
            cellBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cellBackgroundView.heightAnchor.constraint(equalToConstant: 122),
            
            titleLabel.centerYAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
            
            timeBudget.centerYAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 82),
            timeBudget.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
        ])
        
        // nextImageView 설정
        contentView.addSubview(nextImageView)
        nextImageView.image = UIImage(systemName: "chevron.right")
        nextImageView.contentMode = .scaleAspectFit
        nextImageView.tintColor = .base300 // 원하는 색으로 설정
        nextImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nextImageView.centerYAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 40),
            nextImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60),
            nextImageView.widthAnchor.constraint(equalToConstant: 18), // 이미지 뷰의 폭
            nextImageView.heightAnchor.constraint(equalToConstant: 18), // 이미지 뷰의 높이
        ])
        
        // appImage 설정
        contentView.addSubview(appImage)
        appImage.image = UIImage(systemName: "limitapp")
        appImage.contentMode = .scaleAspectFit
//        appImage.tintColor = .base300 // 원하는 색으로 설정
        appImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appImage.centerYAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 82),
            appImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60),
            appImage.widthAnchor.constraint(equalToConstant: 20), // 이미지 뷰의 폭
            appImage.heightAnchor.constraint(equalToConstant: 20), // 이미지 뷰의 높이
        ])
        
        // appImage 설정
        contentView.addSubview(appImage1)
        appImage1.image = UIImage(systemName: "limitapp1")
        appImage1.contentMode = .scaleAspectFit
//        appImage.tintColor = .base300 // 원하는 색으로 설정
        appImage1.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appImage1.centerYAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 82),
            appImage1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -70),
            appImage1.widthAnchor.constraint(equalToConstant: 20), // 이미지 뷰의 폭
            appImage1.heightAnchor.constraint(equalToConstant: 20), // 이미지 뷰의 높이
        ])
        // appImage 설정
        contentView.addSubview(appImage2)
        appImage2.image = UIImage(systemName: "limitapp2")
        appImage2.contentMode = .scaleAspectFit
//        appImage2.tintColor = .base300 // 원하는 색으로 설정
        appImage2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appImage2.centerYAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 82),
            appImage2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -80),
            appImage2.widthAnchor.constraint(equalToConstant: 20), // 이미지 뷰의 폭
            appImage2.heightAnchor.constraint(equalToConstant: 20), // 이미지 뷰의 높이
        ])
        // appImage 설정
        contentView.addSubview(appImage3)
        appImage3.image = UIImage(systemName: "limitapp3")
        appImage3.contentMode = .scaleAspectFit
//        appImage3.tintColor = .base300 // 원하는 색으로 설정
        appImage3.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appImage3.centerYAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 82),
            appImage3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -90),
            appImage3.widthAnchor.constraint(equalToConstant: 20), // 이미지 뷰의 폭
            appImage3.heightAnchor.constraint(equalToConstant: 20), // 이미지 뷰의 높이
        ])
    }
}
