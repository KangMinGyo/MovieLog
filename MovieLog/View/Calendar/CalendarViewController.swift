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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 320, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        self.calendar = calendar
    }
    
    // MARK: - UI Setup
    func setupConstraints() {
        view.addSubview(calendar)
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
