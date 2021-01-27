//
//  MainViewController.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 22.10.2020.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Constants

    private let tokenService = AutenticationService()

    // MARK: - Properties

    private var token = String()

    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tokenService.getToken(sendText: "") { [weak self] (result) in
            guard let self = self,
                  let userData = result,
                  let userDataToken = userData.token
            else {
               return
            }
            self.token = userDataToken
        }
    }

    // MARK: - IBActions

    @IBAction private func getRedWine(_ sender: Any) {
        loadWineByColor(with: WineColors.red)
    }

    @IBAction private func gerWhiteWine(_ sender: Any) {
        loadWineByColor(with: WineColors.white)
    }

    @IBAction private func getRoseWine(_ sender: Any) {
        loadWineByColor(with: WineColors.rose)
    }

    @IBAction private func getAnyWine(_ sender: Any) {
        loadWineByColor(with: WineColors.any)
    }
    
    // MARK: - Private methods

    private func loadWineByColor(with color: String) {
        guard let vc = UIStoryboard(name: String(describing: WineListViewController.self), bundle: Bundle.main)
                .instantiateInitialViewController() as? WineListViewController else {
            fatalError("Please check that WineListViewController is initial View Controller")
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
