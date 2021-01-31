//
//  WineByCategory.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 13.12.2020.
//

import Foundation

struct WineData: Codable {
    let nextskip: Int?
    let category: String?
    var items: [Wine]?
}
struct Wine: Codable {
    let _id: String?
    let id: String?
    let Name: String?
    let Winery: String?
    let Area: String?
    let Province: String?
    let Country: String?
    let Varietal: String?
    let vintage: String?
    let nameClean: String?
    let Style: String?
    let Tags: String?
    //let Type: String?
    let count: Int?
    let rating: Float?
    var fullWineData: FullWineData?
}
