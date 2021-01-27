//
//  UserTableViewController.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 01.11.2020.
//

import UIKit

class UserTableViewController: UIViewController {

    // MARK: - Constants

    private let idCell = "mainCell"
    private let service = NetworkService()

    // MARK: - Properties

    private var typeParam = ""
    var param = (color: String(), token: String())
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

    // MARK: - IBOutlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()

        switch param.color {
        case WineColors.red: typeParam = "tre"
        case WineColors.white: typeParam = "twh"
        case WineColors.rose: typeParam = "tro"
        case WineColors.any: typeParam = "t"
        default:
            typeParam = "t"
        }

        getWines()

    }

    // MARK: - Private methods

    private func configureTableView() {
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: idCell)
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func getWines() {
        service.loadWineByColors(sendText: typeParam, token: param.token) { [weak self] (result) in
            guard let self = self,
                  let wineData = result
            else {
                return
            }
            self.wineData = wineData
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension UserTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wineData?.items.count ?? 0
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
    }
}
