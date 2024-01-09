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
        setUpNavigationBar()
        configureCollectionView()
        setupConstraints()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchPost()
        collectionView.reloadData()
    }
    
    // MARK: - UI Setup
    func setUpNavigationBar() {
        let reviewWriteButton = UIBarButtonItem(image: UIImage(systemName: "pencil"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(searchButtonPressed))
        let boxOfficeButton = UIBarButtonItem(image: UIImage(systemName: "chart.bar.xaxis"),
                                     style: .plain,
                                     target: self,
                                     action: nil)
        let settingButton = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"),
                                     style: .plain,
                                     target: self,
                                     action: nil)
        
        navigationItem.leftBarButtonItem = settingButton
        navigationItem.rightBarButtonItems = [boxOfficeButton, reviewWriteButton]
    }
    
    @objc func searchButtonPressed() {
        let nextVC = SearchViewController()
        self.show(nextVC, sender: self)
    }
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.identifier)
    }
    
    private func setupConstraints() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(0)
        }
    }
    
    // MARK: - Binding
    func bind() {
        viewModel.$review
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                print("VIEW MODEL REVIEW: \(self?.viewModel.review)")
                self?.collectionView.reloadData()
            }.store(in: &subscriptions)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.review.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier, for: indexPath) as! HomeCell
        cell.setup(with: viewModel.review[indexPath.row])
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let nextVC = MovieReviewDetailViewController()
//        nextVC.viewModel.movieData = viewModel.review[indexPath.row]
//        self.show(nextVC, sender: self)
//    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
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

struct MyHomeViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ContentViewControllerPreview {
            let vc = HomeViewController()
            return vc
        }
    }
}
#endif
