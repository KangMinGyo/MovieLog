//
//  ChartViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 2/1/24.
//

import UIKit
import Charts
import DGCharts
import Combine

class ChartViewController: UIViewController {
    
    var viewModel = ChartViewModel()
    var subscriptions = Set<AnyCancellable>()

    // MARK: - UI Components
    lazy var label = UILabel().then {
        $0.text = "일주일간의 리뷰차트"
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    var barChartView: BarChartView = BarChartView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.fetchReviews()
        setupConstraints()
        setupBarChart()
        bind()
    }
    
    // MARK: - UI Setup
    func setupConstraints() {
        view.addSubview(label)
        view.addSubview(barChartView)
        
        label.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaInsets).inset(20)
        }
        
        barChartView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(20)
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
        self.setBarData(barChartView: self.barChartView, barChartDataEntries: self.entryData(values: viewModel.reviewCount))
    }
    
    // MARK: - Binding
    func bind() {
        viewModel.$reviewCount
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.setupBarChart()
                print("qwer: \(self?.viewModel.reviewCount)")
            }.store(in: &subscriptions)
    }

    let dayData: [String] = ["오늘", "1일전", "2일전", "3일전", "4일전", "5일전", "6일전"]
    
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
