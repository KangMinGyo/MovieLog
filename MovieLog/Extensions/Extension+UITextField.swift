//
//  Extension+UITextField.swift
//  MovieLog
//
//  Created by KangMingyo on 12/1/23.
//

import UIKit
import Combine

extension UITextField {
    var publisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            //NotificationCenter로 들어온 notification의 optional 타입 object 프로퍼티를 UITextField로 타입 캐스팅
            .compactMap{ $0.object as? UITextField}
            .map{ $0.text ?? "" }
            .print("[TEXT]: ")
            .eraseToAnyPublisher()
    }
}

// MARK: - Keyboard hide
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

/*NotificationCenter.default
.publisher(for: UITextField.textDidChangeNotification, object: emailTextField)
.map { ($0.object as! UITextField).text ?? "" }
.assign(to: \.email, on: viewModel)
.store(in: &cancellables)
 */
