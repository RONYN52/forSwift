//
//  ViewController.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 22.10.2020.
//

import UIKit

class ViewController: UIViewController {
    private var token = String()
    private lazy var tokenService = AutenticationService()
    @IBOutlet private weak var textOut: UITextField!
    @IBAction private func loadAllUserAction(_ sender: Any) {
       
    }
    // MARK: - ClearTextOnTouch
    @IBAction private func getTextOutAction(_ sender: Any) {
        textOut.text = ""
    }
    // MARK: - CheckingTheInputText
    @IBAction private func inputTextAction(_ sender: Any) {
        guard var _ = textOut.text
        else {
            return textOut.text = ""
        }
    }
    // MARK: - SelectColor and CallFunc
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
    // MARK: - LoadDataFromServers
    private func loadWineByColor(with color: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "UserTableViewController", bundle: nil)
        if #available(iOS 13.0, *) {
            guard let vc = storyBoard.instantiateViewController(identifier: "UserTableViewController") as? UserTableViewController
            else {
                return
            }
            vc.param = (color, token)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            // Fallback on earlier versions
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLoad() {
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
}
