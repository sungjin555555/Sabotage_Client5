//
//  WeekBarVC.swift
//  Sabotage
//
//  Created by 박서윤 on 2024/01/03.
//
//
//import UIKit
//
//class WeekBarVC: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .green
//
//        // 백 버튼을 생성합니다.
//        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
//        navigationItem.leftBarButtonItem = backButton
//    }
//
//    @objc func backButtonTapped() {
//        navigationController?.popViewController(animated: true)
//    }
//
//    // 이하 코드도 계속해서 작성해주세요.
//}

import UIKit

class WeekBarVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green

        // 백 버튼을 생성합니다.
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }

    @objc func backButtonTapped() {
        if let analysisVC = navigationController?.viewControllers.first(where: { $0 is AnalysisVC }) {
            navigationController?.popToViewController(analysisVC, animated: true)
        }
    }
}

