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
        guard let vc = storyBoard.instantiateViewController(identifier: "UserTableViewController") as? UserTableViewController
        else {
            return
        }
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    // MARK: - ClearTextOnTouch
    @IBAction private func getTextOutAction(_ sender: Any) {
        textOut.text = ""
    }
    // MARK: - CheckingTheInputText
    @IBAction private func inputTextAction(_ sender: Any) {
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
                  let textOutString = self.textOut.text,
                  let index = Int(textOutString),
                  let title = user[index - 1].title
            else {
                return
            }
            self.textOut.text = title
        }
    }
}

