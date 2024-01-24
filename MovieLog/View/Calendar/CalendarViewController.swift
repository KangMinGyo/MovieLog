//
//  CalendarViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 1/16/24.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {

    fileprivate weak var calendar: FSCalendar!
    
    // MARK: - UI Components
    lazy var titleLabel = UILabel().then {
        $0.text = "영화제목"
        $0.font = .systemFont(ofSize: 25)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let screenSize = UIScreen.main.bounds.size
        let safeAreaTop = view.safeAreaInsets.top
        
        let calendar = FSCalendar(frame: CGRect(x: 20, y: safeAreaTop + 100, width: screenSize.width - 40, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        self.calendar = calendar
        
        setupConstraints()
    }
    
    // MARK: - UI Setup
    func setupConstraints() {
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaInsets).inset(20)
            $0.height.equalTo(100)
        }
    }
}

extension CalendarViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 1
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("Selected date: \(date)")
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct MyCalendarViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ContentViewControllerPreview {
            let vc = CalendarViewController()
            return vc
        }
    }
}
#endif
