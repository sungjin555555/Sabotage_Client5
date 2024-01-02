import UIKit

class RankingTableView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    let cellIdentifier = "CustomCell"
    let cellCount = 11
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        addSubview(tableView)
        
        // Remove cell separator
        tableView.separatorStyle = .none
        tableView.backgroundColor = .base100
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - TableView DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = .systemPink
        
        let number = UILabel()
        number.translatesAutoresizingMaskIntoConstraints = false
        number.font = .Headline()
        cell.contentView.addSubview(number)
        
        let leftText = UILabel()
        leftText.translatesAutoresizingMaskIntoConstraints = false
        leftText.text = "Left Text"
        leftText.font = .Headline()
        cell.contentView.addSubview(leftText)
        
        let rightText = UILabel()
        rightText.translatesAutoresizingMaskIntoConstraints = false
        rightText.text = "Right Text"
        rightText.font = .Headline()
        rightText.textAlignment = .right
        cell.contentView.addSubview(rightText)
        
        NSLayoutConstraint.activate([
            number.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            number.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 40),
            
            leftText.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            leftText.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 90),
            
            rightText.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            rightText.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -50)
        ])
        
        // 상위 랭킹 3위 안
        if indexPath.row < 3 {
            let button = UIButton(type: .custom)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setBackgroundImage(UIImage(named: "rankingTop3BG"), for: .normal)
            button.contentMode = .scaleAspectFit
            cell.contentView.addSubview(button)
            
            // 초록색 동그라미
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 22), // 버튼의 크기 조정
                button.heightAnchor.constraint(equalToConstant: 22), // 버튼의 크기 조정
                button.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                button.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 35)
            ])
        
            cell.contentView.bringSubviewToFront(number) // 이거 해야 이미지 위에 number 올릴 수 있음.
            number.text = "\(indexPath.row + 1)"
            number.textColor = .base500
            
        }
        // 내 랭킹
        else if indexPath.row == 10 {
            let button = UIButton(type: .custom)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setBackgroundImage(UIImage(named: "myRankingBG"), for: .normal)
            button.contentMode = .scaleAspectFit
            cell.contentView.addSubview(button)
                
            // 내 랭킹 위치
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 310), // 버튼의 크기 조정
                button.heightAnchor.constraint(equalToConstant: 36), // 버튼의 크기 조정
                button.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                button.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
//                button.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 10)
            ])
        
            cell.contentView.bringSubviewToFront(number) // 이거 해야 이미지 위에 number 올릴 수 있음.
            cell.contentView.bringSubviewToFront(leftText)
            cell.contentView.bringSubviewToFront(rightText)
            number.text = "\(indexPath.row + 14)"
            number.textColor = .base500
        }
        else {
            number.text = "\(indexPath.row + 1)"
            number.textColor = indexPath.row == 10 ? .base500 : .base300
        }
        
        switch indexPath.row {

        case ..<3:
            leftText.textColor = .base500
            rightText.textColor = .base500
            cell.frame.size.width = 290
            cell.frame.size.height = 15

        case 3..<10:
            leftText.textColor = .base300
            rightText.textColor = .base300
            cell.frame.size.width = 290 // 상위 랭킹 3위 안의 셀 높이
            cell.frame.size.height = 15

        case 10:
            leftText.textColor = .base500
            rightText.textColor = .base500
            cell.frame.size.width = 290
            cell.frame.size.height = 15
        default:
            break
        }
        
        return cell
    }
}
