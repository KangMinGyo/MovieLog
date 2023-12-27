//
//  WriteViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 12/26/23.
//

import UIKit

class WriteViewController: UIViewController {
    
    // MARK: - UI Components
    lazy var label = UILabel().then {
        $0.text = "어떤점이 좋았나요?"
        $0.font = .systemFont(ofSize: 25)
    }
    
    lazy var reviewTextView = UITextView().then {
        $0.text = "관람평을 작성해주세요."
        $0.font = .systemFont(ofSize: 17)
        $0.textColor = .lightGray
        $0.backgroundColor = .systemGray6
        $0.isScrollEnabled = false
    }
    
    lazy var doneButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 25
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
    
    // MARK: - UI Setup
    func setupConstraints() {
        view.addSubview(label)
        view.addSubview(reviewTextView)
        view.addSubview(doneButton)
        
        label.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY).offset(-view.frame.height/3)
        }
        
        reviewTextView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaInsets).inset(20)
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY)
        }
        
        doneButton.snp.makeConstraints { 
            $0.top.equalTo(reviewTextView.snp.bottom).offset(20)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalTo(150)
            $0.height.equalTo(50)
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct MyWriteViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ContentViewControllerPreview {
            let vc = WriteViewController()
            return vc
        }
    }
}
#endif

struct Previews_WriteViewController_LibraryContent: LibraryContentProvider {
    var views: [LibraryItem] {
        LibraryItem(/*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/)
    }
}
