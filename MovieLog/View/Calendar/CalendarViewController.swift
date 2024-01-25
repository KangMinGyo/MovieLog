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
    
    var viewModel = CalendarViewModel()
    
    // MARK: - UI Components
    lazy var collectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
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
        
        configureCollectionView()
        setupConstraints()
        fetch()
    }
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.identifier)
    }
    
    // MARK: - UI Setup
    func setupConstraints() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaInsets).inset(20)
            $0.bottom.equalTo(view.safeAreaInsets)
        }
    }
    
    func fetch() {
        viewModel.fetchReviews()
    }
    
    func updateCollectionView(with reviews: [Review]) {
        viewModel.reviews = reviews
        collectionView.reloadData()
    }
}

extension CalendarViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let reviewsCount = viewModel.reviews.filter { Calendar.current.isDate($0.date ?? Date(), inSameDayAs: date) }.count
        print("\(viewModel.reviews)")
        return reviewsCount
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // 선택한 날짜에 해당하는 리뷰 가져오기
        let selectedReviews = viewModel.reviews.filter { Calendar.current.isDate($0.date ?? Date(), inSameDayAs: date) }
        updateCollectionView(with: selectedReviews)
    }
}

extension CalendarViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier, for: indexPath) as! HomeCell
        cell.setup(with: viewModel.reviews[indexPath.row])
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let nextVC = MovieReviewDetailViewController()
//        nextVC.viewModel.movieData = viewModel.review[indexPath.row]
//        self.show(nextVC, sender: self)
//    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    //Cell의 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: view.frame.width / 2.5)
    }
    
    //Cell간의 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    //상하좌우 공백
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
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
