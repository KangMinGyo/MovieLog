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
    var posterURL: String?
    
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
                          "posterURL": posterURL ?? "URL 없음",
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

    func upLoadImage(img: UIImage){
        let storage = Storage.storage()
        var data = Data()
        data = img.jpegData(compressionQuality: 0.8)!
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        let title = searchData?.movieNm.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        storage.reference().child("posters/\(title)").putData(data, metadata: metaData){
            (metaData,error) in if let error = error {
                print(error)
                return
            }else{
                print("성공")
            }
        }
    }
    
    func downloadImage() {
        let title = searchData?.movieNm.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
        let imagePath = "posters/\(title)"
        
        let storage = Storage.storage()
        let storageRef = storage.reference(withPath: imagePath)
        
        storageRef.downloadURL { (url, error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                self.posterURL = url?.absoluteString
            }
        }
    }
}
