//
//  BoxOfficeEntity.swift
//  BoxOffice
//
//  Created by TORI on 2023/01/02.
//

import Foundation

struct BoxOfficeEntity: Decodable {
    let boxOfficeResult: BoxOfficeResult
    
    struct BoxOfficeResult: Decodable {
        let dailyBoxOfficeList: [DailyBoxOfficeList]
        
        struct DailyBoxOfficeList: Decodable {
            let openDate: String
            let title: String
            let count: String
            let rank: String
            let imdbId: String
            
            enum CodingKeys: String, CodingKey {
                case openDate = "openDt"
                case title = "movieNm"
                case count = "audiAcc"
                case rank
                case imdbId = "movieCd"
            }
        }
    }
}




