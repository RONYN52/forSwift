//
//  WineInfoTableViewCell.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 09.11.2020.
//

import UIKit
import WebKit

class WineInfoTableViewCell: UITableViewCell {

    // MARK: - Handlers

    var webKitHandler: ((WKWebView?) -> Void)? = nil

    // MARK: - Constants

    static let identifier = String(describing: WineInfoTableViewCell.self)

    // MARK: - Properties

    private var wineDescription = String()

    // MARK: - IBOutlets

    @IBOutlet private weak var labelName: UILabel!
    @IBOutlet private weak var labelOld: UILabel!
    @IBOutlet private weak var labelDescription: UILabel!
    @IBOutlet private weak var previewWebView: WKWebView!


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
        if let description = wineData.fullWineData?.aggregate?.wine?.Varietal {
            wineDescription = "Happy " + description
        } else {
            wineDescription = "Sorry - " + wineVarietal
        }
        labelName.text = wineName
        labelOld.text = wineOld
        labelDescription.text = wineDescription
        webKitHandler?(previewWebView)
    }
}
