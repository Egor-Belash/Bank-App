//
//  NewsModel.swift
//  Bank App
//
//  Created by Egor on 01.05.2026.
//

import Foundation

struct NewsModel: Codable {
    let nameRu: String
    let htmlRu: String
    let img: String
    let startDate: String
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case nameRu = "name_ru"
        case htmlRu = "html_ru"
        case img = "img"
        case startDate = "start_date"
        case link = "link"
    }
    
}
