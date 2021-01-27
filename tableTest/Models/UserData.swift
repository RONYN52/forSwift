//
//  UserData.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 27.10.2020.
//

import Foundation

struct UserData: Codable {
    let id: String?
    let _id: String?
    let name: String?
    let email: String?
    let token: String?
    let creationDate: String?
    let accountType: Int?
    let appStatus: Int?
    let s3AvatarBucket: String?
    let somm: Int?
    let gender: String?
    let hideHistory: Bool?
    let tastExperience: String?
    let wineExperience: [String]?
    let user: User?
}
struct User: Codable {
    let _id: String?
    let email: String?
    let password: String?
    let name: String?
    let token: String?
    let __v: Int?
    let gender: String?
    let location: String?
    let reviews: Int?
    let creationDate: String?
    let role: [String]?
    let accountType: Int?
    let hideHistory: Bool?
    let pricePerBot: [String]?
    let incomeR: String?
    let wineKnowledge: [String]?
    let wineExperience: [String]?
    let tastExperience: String?
    let appStatus: Int?
    let account: String?
    let id: String?
}
