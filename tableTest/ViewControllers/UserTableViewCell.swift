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
    func configure(with: [UserData]){
        for user in with {
        labelTitle.text = user.getTitle()
        guard let id = user.getId(),
              let userId = user.getUserId(),
              let completed = user.getCompleted()
        else {
            return
        }
        labelUserId.text = String(id)
        labelId.text = String(userId)
        labelCompleted.text = completed.description
        }
    }
}
