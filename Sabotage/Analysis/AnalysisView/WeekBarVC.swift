//
//  WeekBarVC.swift
//  Sabotage
//
//  Created by 박서윤 on 2024/01/03.

//import UIKit
//
//class WeekBarVC: UIViewController {
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
//        if let analysisVC = navigationController?.viewControllers.first(where: { $0 is AnalysisVC }) {
//            navigationController?.popToViewController(analysisVC, animated: true)
//        }
//    }
//}


import UIKit
import DGCharts

class WeekBarVC: UIViewController {

    var barGraphView: BarChartView!
    var dataPoints: [String] = ["일","월","화","수","목","금","토"] //dataPoints
    var dataEntries : [BarChartDataEntry] = [] //실질적인 data 배열으로, BarChartDataEntry형 배열을 선언해줘야함
    var dataArray:[Int] = [10,5,6,13,15,8,2] //y축의 데이터가 될 data 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        // BarChartView 생성 및 설정
        barGraphView = BarChartView()
        barGraphView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(barGraphView)
        
        NSLayoutConstraint.activate([
            barGraphView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            barGraphView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            barGraphView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            barGraphView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(dataArray[i]))
            dataEntries.append(dataEntry)
        }
        
        let valFormatter = NumberFormatter()
        valFormatter.numberStyle = .currency
        valFormatter.maximumFractionDigits = 2
        valFormatter.currencySymbol = "$"
                
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        
        //chartDataSet의 label은 그래프 하단 데이터셋의 네이밍을 의미한다.
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "그래프 값 명칭")
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.setValueFormatter(formatter)
        barGraphView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: valFormatter)
                
        barGraphView.data = chartData
    }
}

