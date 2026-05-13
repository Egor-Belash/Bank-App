//
//  ExchangeRatesModel.swift
//  Bank App
//
//  Created by Egor on 27.04.2026.
//

import Foundation

struct ExchangeRatesModel: Codable {
    let kursDateTime: String
    let usdCardIn: String
    let usdCardOut: String
    let eurCardIn: String
    let eurCardOut: String
    let rubCardIn: String
    let rubCardOut: String
    let cnyCardIn: String
    let cnyCardOut: String
    let usdEurCardIn: String
    let usdEurCardOut: String
    let usdRubCardIn: String
    let usdRubCardOut: String
    let rubEurCardIn: String
    let rubEurCardOut: String
    let cnyUsdCardIn: String
    let cnyUsdCardOut: String
    let cnyEurCardIn: String
    let cnyEurCardOut: String
    let cnyRubCardIn: String
    let cnyRubCardOut: String
    
    enum CodingKeys: String, CodingKey {
        case kursDateTime = "kurs_date_time"
        case usdCardIn = "USDCARD_in"
        case usdCardOut = "USDCARD_out"
        case eurCardIn = "EURCARD_in"
        case eurCardOut = "EURCARD_out"
        case rubCardIn = "RUBCARD_in"
        case rubCardOut = "RUBCARD_out"
        case cnyCardIn = "CNYCARD_in"
        case cnyCardOut = "CNYCARD_out"
        case usdEurCardIn = "USDCARD_EURCARD_in"
        case usdEurCardOut = "USDCARD_EURCARD_out"
        case usdRubCardIn = "USDCARD_RUBCARD_in"
        case usdRubCardOut = "USDCARD_RUBCARD_out"
        case rubEurCardIn = "RUBCARD_EURCARD_in"
        case rubEurCardOut = "RUBCARD_EURCARD_out"
        case cnyUsdCardIn = "CNYCARD_USDCARD_in"
        case cnyUsdCardOut = "CNYCARD_USDCARD_out"
        case cnyEurCardIn = "CNYCARD_EURCARD_in"
        case cnyEurCardOut = "CNYCARD_EURCARD_out"
        case cnyRubCardIn = "CNYCARD_RUBCARD_in"
        case cnyRubCardOut = "CNYCARD_RUBCARD_out"
    }
}

