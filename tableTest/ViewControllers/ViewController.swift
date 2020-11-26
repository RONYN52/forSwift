//
//  ViewController.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 22.10.2020.
//

import UIKit

class ViewController: UIViewController {
    private lazy var service = NetworkService()
    @IBOutlet private weak var textOut: UITextField!
    @IBAction private func loadAllUserAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "UserTableViewController", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "UserTableViewController") as! UserTableViewController
        self.present(vc, animated: true, completion: nil)
    }
    // MARK: - ClearTextOnTouch
    @IBAction private func getTextOutAction(_ sender: Any) {
        textOut.text = ""
    }
    // MARK: - CheckingTheInputText
    @IBAction func inputTextAction(_ sender: Any) {
        guard var _ = Int(textOut.text ?? "1")
        else {
            return textOut.text = ""
        }
    }
    // MARK: - LoadDataFromServers
    @IBAction private func loadSingleUserAction(_ sender: Any) {
        service.loadDataFromServers(sendText: ""){ [weak self] (result) in
            guard let self = self,
                  let user = result,
                  let title = user[(Int(self.textOut.text ?? "1") ?? 1) - 1].title
            else {
                return
            }
            self.textOut.text = title
        }
    }
}

