//
//  SearchViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 12/21/23.
//

import UIKit

class SearchViewController: UIViewController {

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
        configureComponent()
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
    
    func configureComponent() {
        view.addSubview(searchTableView)
        
        searchTableView.snp.makeConstraints {
            $0.edges.equalTo(0)
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let nextVC = ReviewWriteViewController()
//        let data = viewModel.searchData[indexPath.row]
//        nextVC.viewModel.searchData = data
//        self.show(nextVC, sender: self)
//    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let movieName = searchBar.text
        print("Movie Search: \(movieName)")
//        viewModel.getSearchDatas(title: "\(movieName ?? "")") {
//            DispatchQueue.main.async {
//                self.movieSearchTableView.reloadData()
//            }
//        }
//        searchBar.resignFirstResponder()
    }
}
