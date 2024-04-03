//
//  BoxOfficeViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 4/2/24.
//

import UIKit
import SnapKit
import Then
import Combine

class BoxOfficeViewController: UIViewController {
    
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
        configureCollectionView()
        setupConstraints()
//        bind()
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
}

extension BoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        viewModel.didSelect(at: indexPath)
//        let nextVC = ReviewDetailViewController()
//        print("viewModel.reviews[indexPath.row]: \(viewModel.reviews[indexPath.row])")
//        nextVC.viewModel.review = viewModel.reviews[indexPath.row]
//        self.show(nextVC, sender: self)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct MyBoxOfficeViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ContentViewControllerPreview {
            let vc = BoxOfficeViewController()
            return vc
        }
    }
}
#endif
