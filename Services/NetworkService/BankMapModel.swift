//
//  BankMapModel.swift
//  Bank App
//
//  Created by Egor on 25.05.2026.
//

import Foundation

struct MapModel: Codable {
    let data: BankData
}

struct BankData: Codable {
    let bank: BankBranch
}

struct BankBranch: Codable {
    let branch: [BranchData]
}

struct BranchData: Codable {
    let postalAddress: PostalAddress
}

struct PostalAddress: Codable {
    let geolocation: Geolocation
}

struct Geolocation: Codable {
    let latitude: String
    let longitude: String
}
