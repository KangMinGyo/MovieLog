//
//  FirebaseManager.swift
//  MovieLog
//
//  Created by KangMingyo on 11/24/23.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore

class FirebaseManager: NSObject {
    
    let auth: Auth
    let storage: Storage
    let fireStore: Firestore
    static let shared = FirebaseManager()
    
    override init() {
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.fireStore = Firestore.firestore()
        super.init()
    }
}
