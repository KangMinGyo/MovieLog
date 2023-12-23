//
//  Extension+UIImage.swift
//  MovieLog
//
//  Created by KangMingyo on 12/23/23.
//

import UIKit

extension UIImage {
    func resize(targetSize: CGSize) -> UIImage? {
        // 1. context를 획득 (사이즈, 투명도, scale 입력)
        // scale의 값이 0이면 현재 화면 기준으로 scale을 잡고, sclae의 값이 1이면 self(이미지) 크기 기준으로 설정
        UIGraphicsBeginImageContextWithOptions(targetSize, true, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.interpolationQuality = .high
        
        // 2. 그리기
        let newRect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)
        draw(in: newRect)
        
        // 3. 그려진 이미지 가져오기
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // 4. context 종료
        UIGraphicsEndImageContext()
        return newImage
    }
}
