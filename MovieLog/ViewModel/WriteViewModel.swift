//
//  WriteViewModel.swift
//  MovieLog
//
//  Created by KangMingyo on 1/5/24.
//

import UIKit
import Combine
import FirebaseStorage

class WriteViewModel: ObservableObject {
    var searchData: MovieList?
    var posterData = [Results]()
    var howData: String?
    var whatData: [Bool]?
    var reviewText: String?
    
    let networkManager = NetworkManager()
    
    var dateString: String? {
        let date =  Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "작성일: yy.MM.dd a hh:mm"
        dateFormatter.locale = Locale(identifier:"ko_KR")
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    // Firebase에 데이터 저장
    func uploadReview() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let reviewData = ["uid": uid,
                          "posterURL": posterData.first?.posterPath ?? "URL 없음",
                          "title": searchData?.movieNm,
                          "director": searchData?.directors.first?.peopleNm,
                          "movieInfo": searchData?.movieInfo,
                          "date": dateString,
                          "how": howData,
                          "what": whatData,
                          "review": reviewText] as [String : Any]
        
        FirebaseManager.shared.fireStore
            .collection("review")
            .document("\(uid)")
            .collection("review")
            .document()
            .setData(reviewData) { err in
                if let err = err {
                    print(err)
                    return
                }
                print("Success")
            }
    }
    
    // Poster 이미지 url 가져오기
    func getMoviePoster(title: String) {
        posterData = [Results]()
        let url = EndPoints.makeMoviePosterApi(
            key: "ab318418ee513b352deb4c9ab21f7ed7",
            title: title
        )
        networkManager.fetchData(for: url,
                                 dataType: Poster.self) { result in
            switch result {
            case .success(let data):
                self.posterData.append(contentsOf: data.results)
            case .failure(let err):
                print(err)
            }
        }
    }

//    // Firebase Storage에 이미지 저장 - x
//    static func uploadImage(image: UIImage, completion: @escaping (URL?) -> Void) {
//        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
//        let metaData = StorageMetadata()
//        metaData.contentType = "image/jpeg"
//        
//        let imageName = UUID().uuidString + String(Date().timeIntervalSince1970)
//        
//        let firebaseReference = Storage.storage().reference().child("\(imageName)")
//        firebaseReference.putData(imageData, metadata: metaData) { metaData, error in
//            firebaseReference.downloadURL { url, _ in
//                completion(url)
//            }
//        }
//    }
//    
//    // Firebase Storage에서 이미지 불러오기 - x
//    static func downloadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
//        let storageReference = Storage.storage().reference(forURL: urlString)
//        let megaByte = Int64(1 * 1024 * 1024)
//        
//        storageReference.getData(maxSize: megaByte) { data, error in
//            guard let imageData = data else {
//                completion(nil)
//                return
//            }
//            completion(UIImage(data: imageData))
//        }
//    }
}
