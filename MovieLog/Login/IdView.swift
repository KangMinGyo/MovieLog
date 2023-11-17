//
//  LoginPasswordView.swift
//  MovieLog
//
//  Created by KangMingyo on 11/15/23.
//

import UIKit
import FlexLayout
import PinLayout

final class IdView: UIView {
    
    // MARK: UI
    let flexContainer = UIView()
    
    let loginIcon = UIImageView()
    let loginTextField = UITextField()
    let line = UIView()
    
    // MARK: Initializing
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        loginIcon.image = UIImage(systemName: "person")
        loginTextField.placeholder = "아이디를 입력하세요"
        
        flexContainer.flex.width(100%).direction(.column).padding(20).define { flex in
            flex.addItem().direction(.row).justifyContent(.spaceBetween).define { flex in
                flex.addItem(loginIcon).grow(1)
            }
        }
        addSubview(flexContainer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.flexContainer.pin.all(self.pin.safeArea)
    }
}


//    lazy var loginIcon: UIImageView = {
//        let view = UIImageView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    lazy var loginTextField: UITextField = {
//        let view = UITextField()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    lazy var line: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()

//private func setupConstraints() {
//    addSubview(loginIcon)
//    addSubview(loginTextField)
//    addSubview(line)
//    
//    NSLayoutConstraint.activate([
//        loginIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//        loginIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//        loginIcon.widthAnchor.constraint(equalToConstant: 30),
//        loginIcon.heightAnchor.constraint(equalToConstant: 30),
//    ])
//    
//    NSLayoutConstraint.activate([
//        line.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 20),
//        line.centerYAnchor.constraint(equalTo: icon.centerYAnchor),
//    ])
//}
