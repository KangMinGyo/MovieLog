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

    // MARK: - UI Components
    var barChartView: BarChartView = BarChartView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstraints()
        setupBarChart()
    }
    
    // MARK: - UI Setup
    func setupConstraints() {
        view.addSubview(barChartView)
        
        barChartView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).inset(20)
            $0.leading.trailing.equalTo(view.safeAreaInsets).inset(20)
            $0.bottom.equalTo(view.safeAreaInsets)
        }
    }
    
    func setupBarChart() {
        self.barChartView.noDataText = "출력 데이터가 없습니다."
        self.barChartView.noDataFont = .systemFont(ofSize: 20)
        self.barChartView.noDataTextColor = .lightGray
        self.barChartView.backgroundColor = .white
    }
}
