//
//  UserTableViewCell.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 09.11.2020.
//

import UIKit
import SVGKit
import WebKit

class UserTableViewCell: UITableViewCell {

    // MARK: - Properties

    private var wineDescription = String()
    private lazy var loadSVGService = NetworkService()

    // MARK: - IBOutlets

    @IBOutlet private weak var labelName: UILabel!
    @IBOutlet private weak var labelOld: UILabel!
    @IBOutlet private weak var labelDescription: UILabel!
    @IBOutlet private weak var labelUserId: UILabel!
    @IBOutlet private weak var imageSVG: WKWebView!

    // MARK: - ConfigureCellWithData

    func configure(with wineData: Wine) {
        guard
            let wineId = wineData.id,
            let wineOld = wineData.vintage,
            let wineName = wineData.Name,
            let wineVarietal = wineData.Varietal
        else {
            return
        }
        if  let description = wineData.fullWineData?.aggregate?.wine?.Varietal {
            wineDescription = "Happy " + description
        } else {
            wineDescription = "Sorry - " + wineVarietal
        }
        labelName.text = wineName
        labelOld.text = wineOld
        labelDescription.text = wineDescription
    }
}
