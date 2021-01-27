//
//  LoadData.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 26.10.2020.
//

import UIKit
import SVGKit

class NetworkService {

    func loadWineByColors(sendText: String,
                          token: String,
                          completion: @escaping (WineData?) -> Void) {

        guard let url = URL(string: URLs.getURL
                                + "/wineCategory/"
                                + sendText
                                + "/0/15")
        else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                let result = try decoder.decode(WineData.self, from: data)
                let winesCount = result.items.count
                for element in 0...winesCount - 1 {
                    if var wine = result.items[element], let wineid = wine.id {
                        self.loadSummaryOfWine(wineId: wineid, token: token) { [weak self] (resultSummary) in
                            guard
                                self != nil,
                                let fullWineData = resultSummary
                            else {
                                return
                            }
                            wine.fullWineData = fullWineData
                        }
                    }
                }
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

    func loadSVGByWine(sendText: String,
                       completion: @escaping (UIImage?) -> Void) {

        guard let url = URL(string: URLs.getSVGURL + "?wine_id=" + sendText)
        else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, respons, error) in
            guard let data = data else {
                return
            }
            let result = UIImage(data: data)
            DispatchQueue.main.async {
                completion(result)
            }
        }.resume()
    }

    func loadSummaryOfWine(wineId: String,
                           token: String,
                           completion: @escaping (FullWineData?) -> Void) {

        let urlString = URLs.getURL + "/wineSummary.json?wine_id=" + wineId
        guard let url = URL(string: urlString)
        else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, respons, error) in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                let result = try decoder.decode(FullWineData.self, from: data)
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch {
                completion(nil)
            }
        }.resume()
    }
}
