//
//  UserRegistrationStruct.swift
//  Bank App
//
//  Created by Egor on 25.04.2026.
//

import Foundation

struct User: Codable {
    let login: String
//    let password: String
    let name: String
    let dateOfBirth: Date
    let phone: String
    let email: String
}
