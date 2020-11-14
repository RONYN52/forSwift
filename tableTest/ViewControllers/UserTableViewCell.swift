//
//  UserTableViewCell.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 09.11.2020.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelUserId: UILabel!
    @IBOutlet weak var labelId: UILabel!
    @IBOutlet weak var labelCompleted: UILabel!
    func configure(with: UserData){
            labelTitle.text = with.title
            guard let id = with.id,
                  let userId = with.userId,
                  let completed = with.completed
        else {
            return
        }
        labelUserId.text = String(id)
        labelId.text = String(userId)
        labelCompleted.text = completed.description
    }
}
