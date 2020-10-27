//
//  LoadData.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 26.10.2020.
//

import UIKit

class LoadData: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadData(sendText: String, completion: @escaping (Item?)->Void) {
   let url = URL(string: "https://jsonplaceholder.typicode.com/todos/"+sendText)!
   URLSession.shared.dataTask(with: url) { (data, respons, error) in
   let decoder = JSONDecoder()
   decoder.keyDecodingStrategy = .convertFromSnakeCase
   guard let data = data else {
       return
   }
   do  {
       let result = try decoder.decode(Item.self, from: data)
       DispatchQueue.main.async {
           guard let id = result.id else {
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

struct Item: Codable {
   let userId: Int?
   let id: Int?
   let title: String?
   let completed: Bool?
}
