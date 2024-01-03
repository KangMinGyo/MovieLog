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
    lazy var headerView = MovieInputFormHeaderView()
    lazy var scrollView = UIScrollView()
    lazy var contentView = CustomStackView()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, 
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, 
                                               object: nil)
        NotificationCenter.default.addObserver(self, 
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - UI Setup
    func setupConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(headerView)
        contentView.addSubview(titlelabel)
        contentView.addSubview(titleTextField)
        contentView.addSubview(directorlabel)
        contentView.addSubview(directorTextField)
        contentView.addSubview(nationlabel)
        contentView.addSubview(nationTextField)
        contentView.addSubview(genrelabel)
        contentView.addSubview(genreTextField)
        contentView.addSubview(yearlabel)
        contentView.addSubview(yearTextField)
        contentView.addSubview(addButton)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(800)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(70)
        }
        
        titlelabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
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
    
    //키보드가 올라올때
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo as NSDictionary?,
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardHeight = keyboardFrame.size.height
        scrollView.contentOffset.y = keyboardHeight
        
    }
    //키보드가 내려갈때
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentOffset.y = .zero
        scrollView.scrollIndicatorInsets = self.scrollView.contentInset
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

