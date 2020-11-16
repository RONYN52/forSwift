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
    @IBAction private func getTextOutAction(_ sender: Any) {
        textOut.text = ""
    }
    @IBAction func inputTextOutAction(_ sender: Any) {
        guard var _ = Int(textOut.text ?? "1")
        else {
            return textOut.text = ""
        }
    }
    @IBAction private func loadSingleUserAction(_ sender: Any) {
        guard
            let sendText = textOut.text
        else {
            return
        }
        service.loadDataFromServers(sendText: sendText){ [weak self] (result) in
            guard let self = self,
                  let user = result,
                  let title = user[0].title
            else {
                return
            }
            self.textOut.text = title
        }
    }
}

