//
//  LoadData.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 26.10.2020.
//

import UIKit

class NetworkService {
    private var page = 0
    private let itemsForOnePage = 10

    func loadWineByColors(sendText: String,
                          token: String,
                          completion: @escaping (WineData?) -> Void) {

        var wineData: WineData?

        guard let url = URL(string: URLs.getURL
                                + "/wineCategory/"
                                + sendText
                                + "/\(page)/\(itemsForOnePage)")
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
                wineData = try decoder.decode(WineData.self, from: data)
            } catch let error {
                completion(nil)
                if let decodingError = error as? DecodingError {
                    print("Error: ", decodingError.errorDescription ?? "error")
                }
            }

            guard var wineData = wineData else {
                return
            }

            let group = DispatchGroup()
            for i in 0 ... (wineData.items?.count ?? 0) - 1 {
                group.enter()
                self.loadSummaryOfWine(wineId: wineData.items?[i].id ?? "",
                                       token: token) { (fullData) in
                    wineData.items?[i].fullWineData = fullData
                    group.leave()
                }
            }
            group.notify(queue: .main) {
                self.page += 1
                completion(wineData)
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
        }.resume()
    }

    func loadSummaryOfWine(wineId: String,
                           token: String,
                           completion: @escaping (FullWineData?) -> Void) {

        let urlString = URLs.getURL + "/wineSummary.json?wine_id=" + wineId
        guard let url = URL(string: urlString) else {
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
