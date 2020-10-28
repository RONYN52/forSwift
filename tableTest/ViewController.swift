//
//  ViewController.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 22.10.2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private lazy var service = NetworkService()
    @IBOutlet private weak var textOut: UITextField!
    @IBOutlet private weak var textIn: UITextView!
    @IBAction func getTextOutAction(_ sender: Any) {
        textOut.text = ""
    }
    @IBAction private func getButtonAction(_ sender: Any) {
        textIn.text = ""
        guard
            let sendText = textOut.text
        else {
            return
        }
        service.loadDataFromServers(sendText: sendText){ [weak self] (results) in
            guard let self = self,
                  let user = results
            else {
                return
            }
            if let title = user.title {
                self.textIn.text.append(title)
            }
        }
    }
}

