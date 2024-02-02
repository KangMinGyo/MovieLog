//
//  ChartViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 2/1/24.
//

import UIKit
import Charts
import DGCharts

class ChartViewController: UIViewController {
    
    var viewModel = ChartViewModel()

    // MARK: - UI Components
    var barChartView: BarChartView = BarChartView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        print("Chart")
        viewModel.fetchReviews()
        setupConstraints()
        setupBarChart()
    }
    
    // MARK: - UI Setup
    func setupConstraints() {
        view.addSubview(barChartView)
        
        barChartView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaInsets).inset(20)
            $0.height.equalTo(200)
        }
    }
    
    func setupBarChart() {
        self.barChartView.noDataText = "출력 데이터가 없습니다."
        self.barChartView.noDataFont = .systemFont(ofSize: 20)
        self.barChartView.noDataTextColor = .lightGray
        self.barChartView.backgroundColor = .white
        self.barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dayData) //구분 값 보이게하기
        self.setBarData(barChartView: self.barChartView, barChartDataEntries: self.entryData(values: self.priceData))
    }

    let dayData: [String] = ["MON", "TUE", "WEN", "THU", "FRI", "SAT", "SUN"]
    let priceData: [Double] = [1, 2, 0, 0, 1, 1, 0]
    
    func entryData(values: [Double]) -> [BarChartDataEntry] {
        var barDataEntries: [BarChartDataEntry] = []
        for i in 0 ..< values.count {
            let barDataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            barDataEntries.append(barDataEntry)
        }
        return barDataEntries
    }
    
    func setBarData(barChartView: BarChartView, barChartDataEntries: [BarChartDataEntry]) {
        let barChartdataSet = BarChartDataSet(entries: barChartDataEntries, label: "리뷰")
        let barChartData = BarChartData(dataSet: barChartdataSet)
        barChartView.data = barChartData
    }
}
