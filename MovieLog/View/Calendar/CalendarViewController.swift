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
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    typealias Item = Review
    
    enum Section {
        case main
    }
    
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
//        collectionView.dataSource = self
//        collectionView.delegate = self
        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: CalendarCell.identifier)
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
        fetch()
        viewModel.reviews = reviews
//        collectionView.reloadData()
        
        // presentation, data, layout
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCell.identifier, for: indexPath) as? CalendarCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.reviews, toSection: .main)
        dataSource.apply(snapshot)
        
        collectionView.collectionViewLayout = layout()
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
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

//extension CalendarViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let nextVC = MovieReviewDetailViewController()
//        nextVC.viewModel.movieData = viewModel.review[indexPath.row]
//        self.show(nextVC, sender: self)
//    }
//}

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
