//
//  AuthenticationService.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 12.12.2020.
//

import UIKit

class AutenticationService {
    func getToken(sendText: String, completion: @escaping (UserData?) -> Void) {
        let loginData = ["email": "ronyn@list.ru", "password": "Testpa$$123"] as [String: Any]
        guard let url = URL(string: URLs.postURL + sendText),
              let jsonBody = try? JSONSerialization.data(withJSONObject: loginData, options: [])
        else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: request) { (data, respons, error) in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let data = data else {
                return
            }
            do {
                let result = try decoder.decode(UserData.self, from: data)
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch let error {
                completion(nil)
                if let decodingError = error as? DecodingError {
                    print("Error: ", decodingError.errorDescription ?? "error")
                }
            }
        }.resume()
    }
}
