//
//  WriteViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 12/26/23.
//

import UIKit

class WriteViewController: UIViewController {
    
    // MARK: - UI Components
    lazy var myReviewLabel: UILabel = {
        let label = UILabel()
        label.text = "나의 관람평"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var reviewTextView: UITextView = {
        let textView = UITextView()
        textView.text = "관람평을 작성해주세요."
        textView.font = .systemFont(ofSize: 17)
        textView.textColor = .lightGray
        textView.backgroundColor = .systemGray6
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
    
    // MARK: - UI Setup
    func setupConstraints() {
        view.addSubview(myReviewLabel)
        view.addSubview(reviewTextView)
        
        myReviewLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY).offset(-60)
        }
        
        reviewTextView.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY)
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
