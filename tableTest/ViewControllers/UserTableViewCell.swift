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
    private var wineDescription = String()
    @IBOutlet private weak var labelName: UILabel!
    @IBOutlet private weak var labelOld: UILabel!
    @IBOutlet private weak var labelDescription: UILabel!
    @IBOutlet private weak var labelUserId: UILabel!
    @IBOutlet private weak var imageSVG: WKWebView!
    private lazy var loadSVGService = NetworkService()
    // MARK: - ConfigureCellWithData
    func configure(with wineData: Wine) {
        guard let wineId = wineData.id,
              let wineOld = wineData.vintage,
              let wineName = wineData.Name,
              let wineVarietal = wineData.Varietal
        else {
            return
        }
        if  let wineProperty = wineData.fullWineData {
            wineDescription = "Happy " + (wineProperty.aggregate?.wine?.Varietal)!
        }
        else {
            wineDescription = "Sorry - " + wineVarietal
        }
        labelName.text = wineName
        labelOld.text = wineOld
        labelDescription.text = wineDescription
        
    }
}
