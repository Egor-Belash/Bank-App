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

//[ {
//    "kurs_date_time" : "2026-04-27 17:20:00",
//    "USDCARD_in" : "2.8100",
//    "USDCARD_out" : "2.8550",
//    "EURCARD_in" : "3.2800",
//    "EURCARD_out" : "3.3500",
//    "RUBCARD_in" : "3.6800",
//    "RUBCARD_out" : "3.7400",
//    "CNYCARD_in" : "4.1800",
//    "CNYCARD_out" : "4.4500",
//    "USDCARD_EURCARD_in" : "0.8420",
//    "USDCARD_EURCARD_out" : "1.1580",
//    "USDCARD_RUBCARD_in" : "75.2000",
//    "USDCARD_RUBCARD_out" : "0.0129",
//    "RUBCARD_EURCARD_out" : "87.8000",
//    "RUBCARD_EURCARD_in" : "0.0110",
//    "CNYCARD_USDCARD_in" : "0.1465",
//    "CNYCARD_USDCARD_out" : "6.3150",
//    "CNYCARD_EURCARD_in" : "0.1250",
//    "CNYCARD_EURCARD_out" : "7.3710",
//    "CNYCARD_RUBCARD_in" : "11.1765",
//    "CNYCARD_RUBCARD_out" : "0.0830"
//} ]
