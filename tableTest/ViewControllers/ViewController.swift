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
    @IBAction private func getTextOutAction(_ sender: Any) {
        textOut.text = ""
    }
    @IBAction private func getButtonAction(_ sender: Any) {
        guard
            let sendText = textOut.text
        else {
            return
        }
        service.loadDataFromServers(sendText: sendText){ [weak self] (results) in
            guard let self = self,
                  let user = results,
                  let title = user.title
            else {
                return
            }
            self.textOut.text = title
        }
    }
}

