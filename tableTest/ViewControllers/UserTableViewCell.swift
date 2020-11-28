//
//  UserTableViewCell.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 09.11.2020.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelUserId: UILabel!
    @IBOutlet private weak var labelId: UILabel!
    @IBOutlet private weak var labelCompleted: UILabel!
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
