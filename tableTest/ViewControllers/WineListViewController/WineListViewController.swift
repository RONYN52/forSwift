//
//  UserTableViewController.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 01.11.2020.
//

import UIKit

class WineListViewController: UIViewController {

    // MARK: - Constants

    private let authService = AuthorizationService()
    private let service = NetworkService()

    // MARK: - Properties

    var wineColor: WineColor?
    private var wines = [Wine]()

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
        loadWines()

    }

    // MARK: - Private methods

    private func configureTableView() {
        tableView.register(UINib(nibName: WineInfoTableViewCell.identifier, bundle: nil),
                           forCellReuseIdentifier: WineInfoTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func loadWines() {
        self.service.loadWineByColors(sendText: self.wineColor?.rawValue ?? "",
                                      token: "5pwib9e40khwwvzzco9c") { [weak self] (result) in
            guard let self = self, let wines = result?.items else {
                return
            }
            self.wines.append(contentsOf: wines)
            self.tableView.reloadData()
        }
//        authService.getToken { [weak self] (token) in
//            guard let self = self else {
//                return
//            }
//
//        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension WineListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wines.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WineInfoTableViewCell.identifier) as? WineInfoTableViewCell
        cell?.configure(with: wines[indexPath.row])
        cell?.webKitHandler = { [weak self] webView in
            guard let self = self else {
                return
            }
            guard let url = URL(string: "https://quiniwine.com/api/pub/wineBloom?wine_id=\(self.wines[indexPath.row].id ?? "")") else {
                return
            }
            webView?.load(URLRequest(url: url))
            webView?.contentScaleFactor = 0.01
        }
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == wines.count - 5 else {
            return
        }
        print("WE NEED NEW WINES TO LOAD")
    }
}
