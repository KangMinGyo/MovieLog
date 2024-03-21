//
//  DateFormatterManager.swift
//  MovieLog
//
//  Created by KangMingyo on 1/31/24.
//

import Foundation

class DateFormatterManager {
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "작성일: yy.MM.dd a hh:mm"
        dateFormatter.locale = Locale(identifier:"ko_KR")
        return dateFormatter
    }()
}
