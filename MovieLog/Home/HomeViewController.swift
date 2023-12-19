//
//  HomeViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 11/24/23.
//

import UIKit
import SnapKit
import Then
import Combine

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct MyHomeViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ContentViewControllerPreview {
            let vc = HomeViewController()
            return vc
        }
    }
}
#endif
