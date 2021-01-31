//
//  AuthorizationRequest.swift
//  tableTest
//
//  Created by Evgeny Syrtsov on 1/27/21.
//

import Foundation
import ObjectMapper

struct AuthorizationRequest: Mappable {

    var token: String = ""

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        token <- map["token"]
    }
}
