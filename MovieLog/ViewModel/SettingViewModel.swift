//
//  SettingViewModel.swift
//  MovieLog
//
//  Created by KangMingyo on 2/15/24.
//

import Foundation

class SettingViewModel: ObservableObject {
    
    @Published var user: User?
    
    let service = ProfileService()
    
    func fetchCurrentUser() {
        print("-----------")
        print("\(FirebaseManager.shared.auth.currentUser?.uid)")
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        service.fetchCurrentUser(uid: uid) { user in
            self.user = user
        }
    }

}
