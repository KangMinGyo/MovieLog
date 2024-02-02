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
        self.setBarData(barChartView: self.barChartView, barChartDataEntries: self.entryData(values: self.priceData))
    }
    
    // MARK: - UI Setup
    func setupConstraints() {
        view.addSubview(barChartView)
        
        barChartView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaInsets).inset(20)
            $0.height.equalTo(200)
        }
    }
    
    func setupBarChart() {
        self.barChartView.noDataText = "출력 데이터가 없습니다."
        self.barChartView.noDataFont = .systemFont(ofSize: 20)
        self.barChartView.noDataTextColor = .lightGray
        self.barChartView.backgroundColor = .white
    }

    let dayData: [String] = ["11월02일", "11월03일", "11월04일", "11월05일", "11월06일", "11월07일", "11월08일"]
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
