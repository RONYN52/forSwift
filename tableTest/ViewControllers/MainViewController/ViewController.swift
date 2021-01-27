//
//  ViewController.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 22.10.2020.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Constants

    private let tokenService = AutenticationService()

    // MARK: - Properties

    private var token = String()

    // MARK: - IBOutlets

    @IBOutlet private weak var textOut: UITextField!

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

    @IBAction private func getTextOutAction(_ sender: Any) {
        textOut.text = ""
    }

    @IBAction private func inputTextAction(_ sender: Any) {
        guard var _ = textOut.text
        else {
            return textOut.text = ""
        }
    }

    @IBAction private func loadAllUserAction(_ sender: Any) {

    }

    // MARK: - Private methods

    private func loadWineByColor(with color: String) {
        guard let vc = UIStoryboard(name: "UserTableViewController", bundle: Bundle.main)
                .instantiateInitialViewController() as? UserTableViewController else {
            fatalError("Please check that UserTableViewController is initial View Controller")
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
