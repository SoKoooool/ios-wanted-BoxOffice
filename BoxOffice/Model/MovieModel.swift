//
//  MovieModel.swift
//  BoxOffice
//
//  Created by TORI on 2023/01/03.
//

import Foundation

struct MovieModel: Codable {
    let rank: String
    let title: String
    let date: String
    let thumbnail: String
    let reply: MovieReply?
}
