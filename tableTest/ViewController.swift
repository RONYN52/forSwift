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
    
    private lazy var service = LoadData()
    @IBOutlet weak var textOut: UITextField!
    @IBOutlet weak var textIn: UITextView!
    @IBAction func getButtonAction(_ sender: Any) {
        textIn.text = ""
        guard
            let sendText = textOut.text
        else {
            return
        }
        service.loadData(sendText: sendText){ [weak self] (results) in
            guard let self = self,
                  let user = results
            else {
                return
            }
            if var title = user.title {
                self.textIn.text.append(user.title ?? "")
            }
        }
    }
}

