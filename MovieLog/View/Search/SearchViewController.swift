//
//  SearchViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 12/21/23.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    
    var viewModel = SearchViewModel()
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - UI Components
    lazy var searchBar = UISearchBar()
    
    lazy var searchTableView = UITableView().then {
        $0.rowHeight = 100
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "영화 검색"
        view.backgroundColor = .systemBackground
        configureTableView()
        setUpSearchBar()
        setupConstraints()
        bind()
    }
    
    //MARK: - Configure
    func configureTableView() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        searchTableView.tableHeaderView = searchBar
    }
    
    func setUpSearchBar() {
        searchBar.delegate = self
        searchBar.frame = (CGRect(x: 0, y: 0, width: 200, height: 70))
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "리뷰 작성 할 영화를 검색해주세요."
    }
    
    // MARK: - UI Setup
    func setupConstraints() {
        view.addSubview(searchTableView)
        
        searchTableView.snp.makeConstraints {
            $0.edges.equalTo(0)
        }
    }
    
    // MARK: - Binding
    func bind() {
        viewModel.$searchData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.searchTableView.reloadData()
            }.store(in: &subscriptions)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        cell.setup(with: viewModel.searchData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = HowViewController()
//        let data = viewModel.searchData[indexPath.row]
//        nextVC.viewModel.searchData = data
        self.show(nextVC, sender: self)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let title = searchBar.text else { return }
        viewModel.configureMovieSearch(title: title)
        searchBar.resignFirstResponder()
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct MySearchViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ContentViewControllerPreview {
            let vc = SearchViewController()
            return vc
        }
    }
}
#endif
