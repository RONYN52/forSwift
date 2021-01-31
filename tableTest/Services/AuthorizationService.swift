//
//  AuthorizationService.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 12.12.2020.
//

import UIKit

class AuthorizationService {

    func getToken(completion: ((String) -> Void)? = nil) {

        let loginData = [
            "email": URLs.userApriori,
            "password": URLs.passApriori
        ] as [String: Any]

        guard
            let url = URL(string: URLs.postURL),
            let httpBody = try? JSONSerialization.data(withJSONObject: loginData, options: [])
        else {
            completion?("")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { (data, respons, error) in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let data = data else {
                completion?("")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let result = AuthorizationRequest(JSON: json as? [String: Any] ?? [ : ])
                if let token = result?.token {
                    DispatchQueue.main.async {
                        completion?(token)
                    }
                }
            } catch let error {
                completion?("")
                if let decodingError = error as? DecodingError {
                    print("Error: ", decodingError.errorDescription ?? "error")
                }
            }
        }.resume()
    }
}
