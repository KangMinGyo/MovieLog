//
//  MovieInputFormView.swift
//  MovieLog
//
//  Created by KangMingyo on 1/3/24.
//

import UIKit
import Combine
import Photos
import PhotosUI

class MovieInputFormViewController: UIViewController {

    var poster = UIImage()
    var viewModel = WriteViewModel()
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - UI Components
    lazy var headerView = MovieInputFormHeaderView()
    lazy var scrollView = UIScrollView()
    lazy var contentView = CustomStackView()
    lazy var titleLabel = CustomInputFormLabel(text: "영화제목")
    lazy var titleTextField = CustomInputFormTextField(fieldType: .title)
    lazy var directorLabel = CustomInputFormLabel(text: "감독이름")
    lazy var directorTextField = CustomInputFormTextField(fieldType: .director)
    lazy var nationLabel = CustomInputFormLabel(text: "제작국가")
    lazy var nationTextField = CustomInputFormTextField(fieldType: .nation)
    lazy var genreLabel = CustomInputFormLabel(text: "장르")
    lazy var genreTextField = CustomInputFormTextField(fieldType: .genre)
    lazy var yearLabel = CustomInputFormLabel(text: "개봉년도")
    lazy var yearTextField = CustomInputFormTextField(fieldType: .year)
    lazy var posterLabel = CustomInputFormLabel(text: "포스터 추가")
    lazy var posterButton = CustomPosterButton()
    lazy var posterImageView = UIImageView().then {
        $0.image = UIImage(named: "Poster")
    }
    lazy var addButton = CustomButton(title: "영화 정보 추가", hasBackground: true, fontSize: .big)
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstraints()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar.isHidden = true
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
        tabBarController?.tabBar.isHidden = false
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - UI Setup
    func setupConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(headerView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(titleTextField)
        contentView.addSubview(directorLabel)
        contentView.addSubview(directorTextField)
        contentView.addSubview(nationLabel)
        contentView.addSubview(nationTextField)
        contentView.addSubview(genreLabel)
        contentView.addSubview(genreTextField)
        contentView.addSubview(yearLabel)
        contentView.addSubview(yearTextField)
        contentView.addSubview(posterLabel)
        contentView.addSubview(posterButton)
        contentView.addSubview(posterImageView)
        contentView.addSubview(addButton)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(1500)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(70)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        
        directorLabel.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        directorTextField.snp.makeConstraints {
            $0.top.equalTo(directorLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        
        nationLabel.snp.makeConstraints {
            $0.top.equalTo(directorTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        nationTextField.snp.makeConstraints {
            $0.top.equalTo(nationLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        
        genreLabel.snp.makeConstraints {
            $0.top.equalTo(nationTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        genreTextField.snp.makeConstraints {
            $0.top.equalTo(genreLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        
        yearLabel.snp.makeConstraints {
            $0.top.equalTo(genreTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        yearTextField.snp.makeConstraints {
            $0.top.equalTo(yearLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        
        posterLabel.snp.makeConstraints {
            $0.top.equalTo(yearTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        posterButton.snp.makeConstraints {
            $0.top.equalTo(posterLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(100)
            $0.height.equalTo(100)
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.equalTo(posterLabel.snp.bottom).offset(10)
            $0.leading.equalTo(posterButton.snp.trailing).offset(10)
            $0.width.equalTo(75)
            $0.height.equalTo(100)
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(posterButton.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
    
    // MARK: - Binding
    func bind() {
        addButton.controlEvent(.touchUpInside)
            .sink { [weak self] _ in
                guard let self = self else { return }
                guard let title = titleTextField.text,
                      let directorName = directorTextField.text,
                      let year = yearTextField.text,
                      let nation = nationTextField.text,
                      let genre = genreTextField.text else {
                    return
                }

                let movieData = MovieList(movieNm: title,
                                          prdtYear: year,
                                          nationAlt: nation,
                                          genreAlt: genre,
                                          directors: [Director(peopleNm: directorName)])
                let vc = HowViewController()
                vc.searchData = movieData
                self.navigationController?.pushViewController(vc, animated: true)
            }.store(in: &subscriptions)
        
        posterButton.controlEvent(.touchUpInside)
            .sink { [weak self] _ in
                self?.pickImage()
        }.store(in: &subscriptions)
    }
    
    // 키보드 올라올때
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo as NSDictionary?,
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardHeight = keyboardFrame.size.height
        scrollView.contentOffset.y = keyboardHeight
        
    }
    // 키보드 내려갈때
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentOffset.y = .zero
        scrollView.scrollIndicatorInsets = self.scrollView.contentInset
    }

    // 갤러리 불러오기
    func pickImage(){
        let photoLibrary = PHPhotoLibrary.shared()
        var configuration = PHPickerConfiguration(photoLibrary: photoLibrary)

        configuration.selectionLimit = 1 // 한번에 가져올 수 있는 이미지 수 제한
        configuration.filter = .any(of: [.images])

        DispatchQueue.main.async {
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            picker.isEditing = true
            self.present(picker, animated: true, completion: nil)
        }
    }
}

extension MovieInputFormViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let itemProvider = results.first?.itemProvider
        
        // UIImage로 추출
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                guard let image = image as? UIImage else { return }
                DispatchQueue.main.async {
                    self.posterImageView.image = image
                    self.poster = image
                }
            }
        }
        // 앨범 닫기
        picker.dismiss(animated: true, completion: nil)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
import Photos

struct MyMovieInputFormViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ContentViewControllerPreview {
            let vc = MovieInputFormViewController()
            return vc
        }
    }
}
#endif
