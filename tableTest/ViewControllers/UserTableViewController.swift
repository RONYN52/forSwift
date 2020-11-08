//
//  UserTableViewController.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 01.11.2020.
//

import UIKit

class UserTableViewController: UIViewController {
    let idCell = "mainCell"
    @IBOutlet weak var tableView: UITableView!
    private lazy var service = NetworkService()
    override func viewDidLoad() {
        super.viewDidLoad()
        service.loadDataFromServers(sendText: URLs.baseURL){ [weak self] (results) in
            guard let self = self,
                  let user = results,
                  let title = user.title
            else {
                return
            }
        }
        tableView.dataSource = self
    }
    @IBAction private func getBackButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension UserTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell)
        if cell == nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: idCell)
            cell.configure(with model: UserData)
        }
        return cell ?? UITableViewCell()
    }
    
    
}

