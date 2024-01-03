//import UIKit
//
//class AnalysisVC: UIViewController {
//    let scrollView = UIScrollView()
//    let contentView = UIView()
//    let TitleLabel = UILabel()
//    let ThisWeek = UILabel()
//    let Change = UILabel()
//    let ExitRank = UILabel()
//    let updateTime = UILabel()
//
////    let weekBarGraphView = WeekBarGraphView()
//    let rankingTableView = RankingTableView()
//    let rankingBG = UIButton(type: .custom)
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//    view.backgroundColor = .green
//        
//    scrollViewUI()
//    contentViewUI()
//    
//    titleUI()
//    rankingUI()
//    
//}
//    func scrollViewUI() {
//        // MARK: - UIScrollView 생성
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.backgroundColor = .white
//        view.addSubview(scrollView)
//        
//        // MARK: ScrollView autolayout 설정
//        NSLayoutConstraint.activate([
//            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
//        ])
//    }
//
//    
//    func contentViewUI() {
//        // MARK: - 스크롤뷰 content 추가
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.backgroundColor = .white
//        scrollView.addSubview(contentView)
//    
//        // MARK: - contentView의 오토레이아웃 설정 -> 이거 해야 스크롤 됨.
////        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
//        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
//        contentViewHeightConstraint.priority = .defaultLow
//        contentViewHeightConstraint.isActive = true
//        
//        NSLayoutConstraint.activate([
//            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
//        ])
//        
//    }
//    
//
//    
//    func titleUI() {
//        // MARK: - contentView에 추가할 content 생성 및 설정
//        TitleLabel.translatesAutoresizingMaskIntoConstraints = false
//        TitleLabel.text = "사용량 분석"
//        TitleLabel.font = UIFont.Title2()
//        TitleLabel.textColor = .black
//        TitleLabel.numberOfLines = 0
//        // MARK: - 스크롤 방향 설정
//        contentView.addSubview(TitleLabel)
//
//        ThisWeek.translatesAutoresizingMaskIntoConstraints = false
//        ThisWeek.text = "이번주"
//        ThisWeek.font = UIFont.Headline()
//        ThisWeek.textColor = .systemMint
//        ThisWeek.numberOfLines = 0
//        contentView.addSubview(ThisWeek) // label3를 contentView에 추가
//        
//        // MARK: 서윤 - test
//        // 이번주 Label에 탭 제스처를 추가합니다.
//        let thisWeekTapGesture = UITapGestureRecognizer(target: self, action: #selector(thisWeekTapped))
//        ThisWeek.isUserInteractionEnabled = true
//        ThisWeek.addGestureRecognizer(thisWeekTapGesture)
//
//        // thisweekimage 이미지를 ThisWeek 밑에 추가
//        let thisweekimage = UIButton(type: .custom)
//        thisweekimage.translatesAutoresizingMaskIntoConstraints = false
//        thisweekimage.contentMode = .scaleAspectFit
//        thisweekimage.backgroundColor = .clear
//        thisweekimage.setImage(UIImage(named: "weeklyBG"), for: .normal)
//        contentView.addSubview(thisweekimage)
//        
////        contentView.addSubview(weekBarGraphView)
////        weekBarGraphView.translatesAutoresizingMaskIntoConstraints = false
////        weekBarGraphView.backgroundColor = .black
////        
////        // weekBarGraphView를 thisweekimage 위에 추가
////        contentView.insertSubview(weekBarGraphView, aboveSubview: thisweekimage)
////        weekBarGraphView.translatesAutoresizingMaskIntoConstraints = false
////        weekBarGraphView.backgroundColor = .black // 적절한 배경색으로 설정합니다.
//        
////        contentView.bringSubviewToFront(weekBarGraphView)
//        
//        Change.translatesAutoresizingMaskIntoConstraints = false
//        Change.text = "사용 변화량"
//        Change.font = UIFont.Headline()
//        Change.textColor = .systemPink
//        Change.numberOfLines = 0
//        contentView.addSubview(Change)
//
//        // changeimage 이미지를 Change 밑에 추가
//        let changeimage = UIButton(type: .custom)
//        changeimage.translatesAutoresizingMaskIntoConstraints = false
//        changeimage.contentMode = .scaleAspectFit
//        changeimage.backgroundColor = .clear
//        changeimage.setImage(UIImage(named: "changeBG"), for: .normal)
//        contentView.addSubview(changeimage)
//
//        // MARK: - contentView에 추가할 content 생성 및 설정
//        ExitRank.translatesAutoresizingMaskIntoConstraints = false
//        ExitRank.text = "EXIT 랭킹"
//        ExitRank.font = UIFont.Headline()
//        ExitRank.textColor = .black
//        ExitRank.numberOfLines = 0
//        contentView.addSubview(ExitRank)
//
//
//        NSLayoutConstraint.activate([
//
//            TitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
//            TitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//
//            ThisWeek.topAnchor.constraint(equalTo: TitleLabel.bottomAnchor, constant: 50),
//            ThisWeek.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//
//            // thisweekimage 이미지 위치 설정
//            thisweekimage.topAnchor.constraint(equalTo: ThisWeek.bottomAnchor, constant: 20),
//            thisweekimage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            thisweekimage.widthAnchor.constraint(equalToConstant: 343),
//            thisweekimage.heightAnchor.constraint(equalToConstant: 320), // 이미지 크기에 맞게 조정
//            
////            weekBarGraphView.topAnchor.constraint(equalTo: thisweekimage.bottomAnchor, constant: 20),
////            weekBarGraphView.centerXAnchor.constraint(equalTo: thisweekimage.centerXAnchor),
////            weekBarGraphView.widthAnchor.constraint(equalToConstant: 333),
////            weekBarGraphView.heightAnchor.constraint(equalToConstant: 310), // 적절한 높이 설정
//            
//            Change.topAnchor.constraint(equalTo: thisweekimage.bottomAnchor, constant: 50),
//            Change.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//
//
//            changeimage.topAnchor.constraint(equalTo: Change.bottomAnchor, constant: 20),
//            changeimage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            changeimage.widthAnchor.constraint(equalToConstant: 343),
//            changeimage.heightAnchor.constraint(equalToConstant: 255), // 이미지 크기에 맞게 조정
//
//
//            // ExitRank 위치 설정
//            ExitRank.topAnchor.constraint(equalTo: changeimage.bottomAnchor, constant: 20),
//            ExitRank.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//
//
//            //            updateTime.topAnchor.constraint(equalTo: rankingTableView.bottomAnchor, constant: -200),
//            //            updateTime.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//        ])
//    }
//    
//    func rankingUI() {
//        // 테이블 뷰를 먼저 contentView에 추가합니다.
//        rankingTableView.translatesAutoresizingMaskIntoConstraints = false
//        rankingTableView.backgroundColor = .systemPink
//        contentView.addSubview(rankingTableView)
//        
//        NSLayoutConstraint.activate([
//            // 테이블 뷰 위치 설정
//            rankingTableView.topAnchor.constraint(equalTo: ExitRank.bottomAnchor, constant: 20),
//            rankingTableView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
////            rankingTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
////            rankingTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            rankingTableView.widthAnchor.constraint(equalToConstant: 343),
//            rankingTableView.heightAnchor.constraint(equalToConstant: 403)
////            rankingTableView.heightAnchor.constraint(equalToConstant: CGFloat(rankingTableView.cellCount * 50) - 50),
////            rankingTableView.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 20),
////            rankingTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
////            rankingTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
////            rankingTableView.heightAnchor.constraint(equalToConstant: CGFloat(rankingTableView.cellCount * 50)),
//        ])
//        
//        // rankingBG를 contentView에 추가합니다.
//            rankingBG.translatesAutoresizingMaskIntoConstraints = false
//            rankingBG.contentMode = .scaleAspectFit
//            rankingBG.backgroundColor = .clear
//            rankingBG.setImage(UIImage(named: "RankingBG"), for: .normal)
//            contentView.addSubview(rankingBG)
//        
//        // rankingBG를 rankingTableView 위에 올리기 위해 순서를 조정합니다.
//        // contentView.bringSubviewToFront(rankingBG)
//        contentView.bringSubviewToFront(ExitRank)
//        contentView.bringSubviewToFront(rankingTableView)
//        
//        NSLayoutConstraint.activate([
//            // 배경 이미지 버튼 위치 설정
//            rankingBG.topAnchor.constraint(equalTo: ExitRank.topAnchor, constant: -20),
//            rankingBG.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            rankingBG.widthAnchor.constraint(equalToConstant: 343),
////            rankingBG.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
////            rankingBG.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
////            rankingBG.heightAnchor.constraint(equalToConstant: CGFloat(rankingTableView.cellCount * 50) + 180),
//            rankingBG.heightAnchor.constraint(equalToConstant: 512)
//        ])
//        
//        // 스크롤뷰 길이 확인을 위한 이미지
//        let newImageView = UIImageView()
//        newImageView.translatesAutoresizingMaskIntoConstraints = false
//        newImageView.contentMode = .scaleAspectFit
//        newImageView.backgroundColor = .systemPink // 원하는 색상으로 변경하세요
//        newImageView.image = UIImage(named: "YourImageName") // 이미지를 넣어주세요
//        contentView.addSubview(newImageView)
//        
//        NSLayoutConstraint.activate([
//            newImageView.topAnchor.constraint(equalTo: rankingBG.bottomAnchor, constant: 100),
//            newImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            newImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            newImageView.heightAnchor.constraint(equalToConstant: 200), // 이미지 높이 조정
//            newImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20), // contentView 하단과 이미지 간격 조정
//        ])
//    }
//    // MARK: 서윤 - test
//    // ThisWeek 라벨을 눌렀을 때 실행될 메서드를 추가합니다.
//    @objc func thisWeekTapped() {
//        // WeekBar 화면으로 이동하는 코드를 추가합니다.
//        let weekBarVC = WeekBarVC() // 이동할 WeekBarViewController 생성
//        navigationController?.pushViewController(weekBarVC, animated: true) // WeekBarViewController로 이동
//    }
//
//}

import UIKit

class AnalysisVC: UIViewController {
    let scrollView = UIScrollView()
    let contentView = UIView()
    let TitleLabel = UILabel()
    let ThisWeek = UILabel()
    let Change = UILabel()
    let ExitRank = UILabel()
    let updateTime = UILabel()

//    let weekBarGraphView = WeekBarGraphView()
    let rankingTableView = RankingTableView()
    let rankingBG = UIButton(type: .custom)

override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .green
        
    scrollViewUI()
    contentViewUI()
    
    titleUI()
    rankingUI()
    
}
    func scrollViewUI() {
        // MARK: - UIScrollView 생성
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        view.addSubview(scrollView)
        
        // MARK: ScrollView autolayout 설정
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    
    func contentViewUI() {
        // MARK: - 스크롤뷰 content 추가
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        scrollView.addSubview(contentView)
    
        // MARK: - contentView의 오토레이아웃 설정 -> 이거 해야 스크롤 됨.
//        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        let contentViewHeightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentViewHeightConstraint.priority = .defaultLow
        contentViewHeightConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
    }
    

    
    func titleUI() {
        // MARK: - contentView에 추가할 content 생성 및 설정
        TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        TitleLabel.text = "사용량 분석"
        TitleLabel.font = UIFont.Title2()
        TitleLabel.textColor = .black
        TitleLabel.numberOfLines = 0
        // MARK: - 스크롤 방향 설정
        contentView.addSubview(TitleLabel)

        ThisWeek.translatesAutoresizingMaskIntoConstraints = false
        ThisWeek.text = "이번주"
        ThisWeek.font = UIFont.Headline()
        ThisWeek.textColor = .systemMint
        ThisWeek.numberOfLines = 0
        contentView.addSubview(ThisWeek) // label3를 contentView에 추가
        
        // MARK: 서윤 - test
        // 이번주 Label에 탭 제스처를 추가합니다.
        let thisWeekTapGesture = UITapGestureRecognizer(target: self, action: #selector(thisWeekTapped))
        ThisWeek.isUserInteractionEnabled = true
        ThisWeek.addGestureRecognizer(thisWeekTapGesture)

        // thisweekimage 이미지를 ThisWeek 밑에 추가
        let thisweekimage = UIButton(type: .custom)
        thisweekimage.translatesAutoresizingMaskIntoConstraints = false
        thisweekimage.contentMode = .scaleAspectFit
        thisweekimage.backgroundColor = .clear
        thisweekimage.setImage(UIImage(named: "weeklyBG"), for: .normal)
        contentView.addSubview(thisweekimage)
        
//        contentView.addSubview(weekBarGraphView)
//        weekBarGraphView.translatesAutoresizingMaskIntoConstraints = false
//        weekBarGraphView.backgroundColor = .black
//
//        // weekBarGraphView를 thisweekimage 위에 추가
//        contentView.insertSubview(weekBarGraphView, aboveSubview: thisweekimage)
//        weekBarGraphView.translatesAutoresizingMaskIntoConstraints = false
//        weekBarGraphView.backgroundColor = .black // 적절한 배경색으로 설정합니다.
        
//        contentView.bringSubviewToFront(weekBarGraphView)
        
        Change.translatesAutoresizingMaskIntoConstraints = false
        Change.text = "사용 변화량"
        Change.font = UIFont.Headline()
        Change.textColor = .systemPink
        Change.numberOfLines = 0
        contentView.addSubview(Change)

        // changeimage 이미지를 Change 밑에 추가
        let changeimage = UIButton(type: .custom)
        changeimage.translatesAutoresizingMaskIntoConstraints = false
        changeimage.contentMode = .scaleAspectFit
        changeimage.backgroundColor = .clear
        changeimage.setImage(UIImage(named: "changeBG"), for: .normal)
        contentView.addSubview(changeimage)

        // MARK: - contentView에 추가할 content 생성 및 설정
        ExitRank.translatesAutoresizingMaskIntoConstraints = false
        ExitRank.text = "EXIT 랭킹"
        ExitRank.font = UIFont.Headline()
        ExitRank.textColor = .black
        ExitRank.numberOfLines = 0
        contentView.addSubview(ExitRank)


        NSLayoutConstraint.activate([

            TitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            TitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            ThisWeek.topAnchor.constraint(equalTo: TitleLabel.bottomAnchor, constant: 50),
            ThisWeek.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            // thisweekimage 이미지 위치 설정
            thisweekimage.topAnchor.constraint(equalTo: ThisWeek.bottomAnchor, constant: 20),
            thisweekimage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            thisweekimage.widthAnchor.constraint(equalToConstant: 343),
            thisweekimage.heightAnchor.constraint(equalToConstant: 320), // 이미지 크기에 맞게 조정
            
//            weekBarGraphView.topAnchor.constraint(equalTo: thisweekimage.bottomAnchor, constant: 20),
//            weekBarGraphView.centerXAnchor.constraint(equalTo: thisweekimage.centerXAnchor),
//            weekBarGraphView.widthAnchor.constraint(equalToConstant: 333),
//            weekBarGraphView.heightAnchor.constraint(equalToConstant: 310), // 적절한 높이 설정
            
            Change.topAnchor.constraint(equalTo: thisweekimage.bottomAnchor, constant: 50),
            Change.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),


            changeimage.topAnchor.constraint(equalTo: Change.bottomAnchor, constant: 20),
            changeimage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            changeimage.widthAnchor.constraint(equalToConstant: 343),
            changeimage.heightAnchor.constraint(equalToConstant: 255), // 이미지 크기에 맞게 조정


            // ExitRank 위치 설정
            ExitRank.topAnchor.constraint(equalTo: changeimage.bottomAnchor, constant: 20),
            ExitRank.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),


            //            updateTime.topAnchor.constraint(equalTo: rankingTableView.bottomAnchor, constant: -200),
            //            updateTime.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    func rankingUI() {
        // 테이블 뷰를 먼저 contentView에 추가합니다.
        rankingTableView.translatesAutoresizingMaskIntoConstraints = false
        rankingTableView.backgroundColor = .systemPink
        contentView.addSubview(rankingTableView)
        
        NSLayoutConstraint.activate([
            // 테이블 뷰 위치 설정
            rankingTableView.topAnchor.constraint(equalTo: ExitRank.bottomAnchor, constant: 20),
            rankingTableView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            rankingTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            rankingTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            rankingTableView.widthAnchor.constraint(equalToConstant: 343),
            rankingTableView.heightAnchor.constraint(equalToConstant: 403)
//            rankingTableView.heightAnchor.constraint(equalToConstant: CGFloat(rankingTableView.cellCount * 50) - 50),
//            rankingTableView.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 20),
//            rankingTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            rankingTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
//            rankingTableView.heightAnchor.constraint(equalToConstant: CGFloat(rankingTableView.cellCount * 50)),
        ])
        
        // rankingBG를 contentView에 추가합니다.
            rankingBG.translatesAutoresizingMaskIntoConstraints = false
            rankingBG.contentMode = .scaleAspectFit
            rankingBG.backgroundColor = .clear
            rankingBG.setImage(UIImage(named: "RankingBG"), for: .normal)
            contentView.addSubview(rankingBG)
        
        // rankingBG를 rankingTableView 위에 올리기 위해 순서를 조정합니다.
        // contentView.bringSubviewToFront(rankingBG)
        contentView.bringSubviewToFront(ExitRank)
        contentView.bringSubviewToFront(rankingTableView)
        
        NSLayoutConstraint.activate([
            // 배경 이미지 버튼 위치 설정
            rankingBG.topAnchor.constraint(equalTo: ExitRank.topAnchor, constant: -20),
            rankingBG.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            rankingBG.widthAnchor.constraint(equalToConstant: 343),
//            rankingBG.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
//            rankingBG.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//            rankingBG.heightAnchor.constraint(equalToConstant: CGFloat(rankingTableView.cellCount * 50) + 180),
            rankingBG.heightAnchor.constraint(equalToConstant: 512)
        ])
        
        // 스크롤뷰 길이 확인을 위한 이미지
        let newImageView = UIImageView()
        newImageView.translatesAutoresizingMaskIntoConstraints = false
        newImageView.contentMode = .scaleAspectFit
        newImageView.backgroundColor = .systemPink // 원하는 색상으로 변경하세요
        newImageView.image = UIImage(named: "YourImageName") // 이미지를 넣어주세요
        contentView.addSubview(newImageView)
        
        NSLayoutConstraint.activate([
            newImageView.topAnchor.constraint(equalTo: rankingBG.bottomAnchor, constant: 100),
            newImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            newImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            newImageView.heightAnchor.constraint(equalToConstant: 200), // 이미지 높이 조정
            newImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20), // contentView 하단과 이미지 간격 조정
        ])
    }
    // MARK: 서윤 - test
    // ThisWeek 라벨을 눌렀을 때 실행될 메서드를 추가합니다.
    @objc func thisWeekTapped() {
        // WeekBar 화면으로 이동하는 코드를 추가합니다.
        let weekBarVC = WeekBarVC() // 이동할 WeekBarViewController 생성
        navigationController?.pushViewController(weekBarVC, animated: true) // WeekBarViewController로 이동
    }

}
