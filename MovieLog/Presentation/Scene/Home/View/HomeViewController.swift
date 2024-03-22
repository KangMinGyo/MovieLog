//
//  HomeViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 11/24/23.
//

import UIKit
import SnapKit
import Then
import Combine

class HomeViewController: UIViewController {
    
    var viewModel = HomeViewModel()
    var subscriptions = Set<AnyCancellable>()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    typealias Item = Review
    
    enum Section {
        case main
    }
    
    // MARK: - UI Components
    lazy var collectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        return collectionView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        configureCollectionView()
        setupConstraints()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetch()
    }

    // MARK: - UI Setup
    func setUpNavigationBar() {
        let reviewWriteButton = UIBarButtonItem(image: UIImage(systemName: "pencil"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(searchButtonPressed))
        reviewWriteButton.tintColor = .black
        let boxOfficeButton = UIBarButtonItem(image: UIImage(systemName: "chart.bar.xaxis"),
                                     style: .plain,
                                     target: self,
                                     action: nil)
        boxOfficeButton.tintColor = .black
        let settingButton = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"),
                                     style: .plain,
                                     target: self,
                                     action: nil)
        settingButton.tintColor = .black
        
        navigationItem.leftBarButtonItem = settingButton
        navigationItem.rightBarButtonItems = [boxOfficeButton, reviewWriteButton]
    }
    
    @objc func searchButtonPressed() {
        let nextVC = SearchViewController()
        self.show(nextVC, sender: self)
    }
    
    func configureCollectionView() {
//        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.identifier)
        
        // presentation, data, layout
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier, for: indexPath) as? HomeCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })

        collectionView.collectionViewLayout = layout()
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.20))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func setupConstraints() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(0)
        }
    }
    
    // MARK: - Binding
    func bind() {
        viewModel.$reviews
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapshot.appendSections([.main])
                if let items = self?.viewModel.reviews {
                    snapshot.appendItems(items, toSection: .main)
                }
                self?.dataSource.apply(snapshot)
            }.store(in: &subscriptions)
        
        viewModel.selectedItem
            .compactMap { $0 }
            .receive(on: RunLoop.main)
            .sink { review in
                let nextVC = ReviewDetailViewController()
                nextVC.viewModel = ReviewDetailViewModel(review: review)
                self.present(nextVC, animated: true)
            }.store(in: &subscriptions)
    }
    
    func fetch() {
        viewModel.fetchReviews()
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelect(at: indexPath)
//        let nextVC = ReviewDetailViewController()
//        print("viewModel.reviews[indexPath.row]: \(viewModel.reviews[indexPath.row])")
//        nextVC.viewModel.review = viewModel.reviews[indexPath.row]
//        self.show(nextVC, sender: self)
    }
}

//extension HomeViewController: UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.reviews.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier, for: indexPath) as! HomeCell
//        cell.setup(with: viewModel.reviews[indexPath.row])
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let nextVC = MovieReviewDetailViewController()
//        nextVC.viewModel.movieData = viewModel.review[indexPath.row]
//        self.show(nextVC, sender: self)
//    }
//}

//extension HomeViewController: UICollectionViewDelegateFlowLayout {
//    //Cell의 크기
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width - 20, height: view.frame.width / 2.5)
//    }
//    
//    //Cell간의 간격
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//    
//    //상하좌우 공백
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//    }
//}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct MyHomeViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ContentViewControllerPreview {
            let vc = HomeViewController()
            return vc
        }
    }
}
#endif
