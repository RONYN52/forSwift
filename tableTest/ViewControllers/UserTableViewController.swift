//
//  UserTableViewController.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 01.11.2020.
//

import UIKit

class UserTableViewController: UIViewController {
    private let idCell = "mainCell"
    private var cellCounter = 0
    @IBOutlet weak var tableView: UITableView!
    private lazy var service = NetworkService()
    private var userData: [UserData]? {
        didSet {
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: idCell)
        service.loadDataFromServers(sendText: ""){ [weak self] (result) in
            guard let self = self,
                  let user = result
            else {
                return
            }
            self.userData = user
        }
        tableView.dataSource = self
        
    }
    @IBAction private func getBackButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension UserTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cellCount = self.userData?.count
        else {
            return 0
        }
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell) as? UserTableViewCell
        if let allUser = self.userData {
            cell?.configure(with: allUser[indexPath.row])
        }
        return cell ?? UITableViewCell()
    }
    
    
}

