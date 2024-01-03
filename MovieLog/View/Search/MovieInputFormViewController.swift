//
//  MovieInputFormView.swift
//  MovieLog
//
//  Created by KangMingyo on 1/3/24.
//

import UIKit
import Combine

class MovieInputFormViewController: UIViewController {
    
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - UI Components
//    lazy var scrollView = UIScrollView()
//    lazy var contentView = CustomStackView()
    lazy var titlelabel = CustomInputFormLabel(text: "영화제목")
    lazy var titleTextField = CustomInputFormTextField(fieldType: .title)
    lazy var directorlabel = CustomInputFormLabel(text: "감독이름")
    lazy var directorTextField = CustomInputFormTextField(fieldType: .director)
    lazy var nationlabel = CustomInputFormLabel(text: "제작국가")
    lazy var nationTextField = CustomInputFormTextField(fieldType: .nation)
    lazy var genrelabel = CustomInputFormLabel(text: "장르")
    lazy var genreTextField = CustomInputFormTextField(fieldType: .genre)
    lazy var yearlabel = CustomInputFormLabel(text: "개봉년도")
    lazy var yearTextField = CustomInputFormTextField(fieldType: .year)
    lazy var addButton = CustomButton(title: "영화 정보 추가", hasBackground: true, fontSize: .big)
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstraints()
    }
    
    // MARK: - UI Setup
    func setupConstraints() {
        view.addSubview(titlelabel)
        view.addSubview(titleTextField)
        view.addSubview(directorlabel)
        view.addSubview(directorTextField)
        view.addSubview(nationlabel)
        view.addSubview(nationTextField)
        view.addSubview(genrelabel)
        view.addSubview(genreTextField)
        view.addSubview(yearlabel)
        view.addSubview(yearTextField)
        view.addSubview(addButton)
        
        titlelabel.snp.makeConstraints {
            $0.top.equalTo(0).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(titlelabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        
        directorlabel.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        directorTextField.snp.makeConstraints {
            $0.top.equalTo(directorlabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        
        nationlabel.snp.makeConstraints {
            $0.top.equalTo(directorTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        nationTextField.snp.makeConstraints {
            $0.top.equalTo(nationlabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        
        genrelabel.snp.makeConstraints {
            $0.top.equalTo(nationTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        genreTextField.snp.makeConstraints {
            $0.top.equalTo(genrelabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        
        yearlabel.snp.makeConstraints {
            $0.top.equalTo(genreTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        yearTextField.snp.makeConstraints {
            $0.top.equalTo(yearlabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(yearTextField.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct MyMovieInputFormViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ContentViewControllerPreview {
            let vc = MovieInputFormViewController()
            return vc
        }
    }
}
#endif

