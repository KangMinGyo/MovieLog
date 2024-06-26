//
//  SearchViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 12/21/23.
//

import UIKit
import Combine
import MovieLog_Resource

class SearchViewController: UIViewController {
    
    var viewModel = SearchViewModel()
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - UI Components
    lazy var searchBar = UISearchBar()
    
    lazy var searchTableView = UITableView().then {
        $0.rowHeight = 100
    }
    
    lazy var movieRegistrationView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    lazy var label = UILabel().then {
        $0.text = "noMovieFound".localized
        $0.font = .systemFont(ofSize: 18)
    }
    
    lazy var button = UIButton().then {
        $0.setTitle("addMovie".localized, for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = R.Color.green
        $0.layer.cornerRadius = 25
        $0.layer.masksToBounds = true
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "movieSearch".localized
        view.backgroundColor = .systemBackground
        configureTableView()
        setUpSearchBar()
        setupConstraints()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
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
        searchBar.placeholder = "searchMessage".localized
    }
    
    // MARK: - UI Setup
    func setupConstraints() {
        view.addSubview(searchTableView)
        view.addSubview(movieRegistrationView)
        movieRegistrationView.addSubview(label)
        movieRegistrationView.addSubview(button)
        
        searchTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(0)
            $0.bottom.equalToSuperview().offset(-150)
        }
        
        movieRegistrationView.snp.makeConstraints {
            $0.top.equalTo(searchTableView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(0)
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(0).offset(20)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(20)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
    }
    
    // MARK: - Binding
    func bind() {
        viewModel.$searchData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.searchTableView.reloadData()
            }.store(in: &subscriptions)
        
        button.controlEvent(.touchUpInside)
            .sink { [weak self] _ in
                let vc = MovieInputFormViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
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
        let data = viewModel.searchData[indexPath.row]
        nextVC.searchData = data
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
