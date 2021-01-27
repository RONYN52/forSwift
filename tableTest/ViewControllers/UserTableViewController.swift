//
//  UserTableViewController.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 01.11.2020.
//

import UIKit

class UserTableViewController: UIViewController, UITableViewDelegate {
    private let idCell = "mainCell"
    private var typeParam = ""
    var param = (color: String(), token: String())
    @IBOutlet private weak var tableView: UITableView!
    private lazy var service = NetworkService()
    private var wineData: WineData? {
        didSet {
            tableView.reloadData()
        }
    }
    private var fullWineData: FullWineData? {
        didSet {
            tableView.reloadData()
        }
    }
    // MARK: - DataSource
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: idCell)
        switch (param.color) {
        case WineColors.red: typeParam = "tre";
        case WineColors.white: typeParam = "twh";
        case WineColors.rose: typeParam = "tro";
        case WineColors.any: typeParam = "t"
        default:
            typeParam = "t"
        };
        service.loadWineByColors(sendText: typeParam, token: param.token) { [weak self] (result) in
            guard let self = self,
                  let wineData = result
            else {
                return
            }
            self.wineData = wineData
            guard let wines = self.wineData
            else {
                return
            }
        }
        tableView.dataSource = self
        tableView.delegate = self
    }
}
// MARK: - CreateTableCell
extension UserTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cellCount = self.wineData?.items.count
        else {
            return 0
        }
        return cellCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell) as? UserTableViewCell
                guard let allWine = self.wineData,
                      let wine = allWine.items[indexPath.row]
                else {
                    return cell ?? UITableViewCell()
                }
        cell?.configure(with: wine)
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            if tableView.visibleCells.contains(cell) {
                print("will")
            }
        })
    }
}
