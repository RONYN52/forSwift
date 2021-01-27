//
//  WineSummaryInfo.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 15.12.2020.
//

import Foundation

struct FullWineData: Codable {
    let aggregate: WineProperty?
    let agg_summary: Agg_summary?
}
struct WineProperty: Codable {
    let scoreAvg: [Float]?
    let wine: WineInfo?
    let count: Int?
}
struct WineInfo: Codable {
    let id: String?
    let Name: String?
    let Winery: String?
    let vintage: String?
    let Country: String?
    let Area: String?
    let Style: String?
    let Varietal: String?
    //let Type: String?
}
struct Agg_summary: Codable {
    let textReviews: TextReviews?
}
struct TextReviews: Codable {
    let eye: String?
    let nose: String?
    let mouth: String?
    let finish: String?
    let overall: String?
}
