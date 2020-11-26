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
    // MARK: - ConfigureCellWithData
    func configure(with userData: UserData){
        labelTitle.text = userData.title
        guard let id = userData.id,
              let userId = userData.userId,
              let completed = userData.completed
        else {
            return
        }
        labelUserId.text = String(id)
        labelId.text = String(userId)
        labelCompleted.text = completed.description
    }
}
