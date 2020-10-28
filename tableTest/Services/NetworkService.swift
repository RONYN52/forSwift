//
//  LoadData.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 26.10.2020.
//

import UIKit

class NetworkService {
    
    func loadDataFromServers(sendText: String, completion: @escaping (UserData?) -> Void) {
        if let url = URL(string: URLs.baseURL + sendText) {
   URLSession.shared.dataTask(with: url) { (data, respons, error) in
   let decoder = JSONDecoder()
   decoder.keyDecodingStrategy = .convertFromSnakeCase
   guard let data = data else {
       return
   }
   do  {
       let result = try decoder.decode(UserData.self, from: data)
       DispatchQueue.main.async {
           guard let _ = result.id else {
                return
           }
                completion(result.self)
                                }
        } catch  {
            completion(nil)
                 }
        }.resume()
        }
    }
}


