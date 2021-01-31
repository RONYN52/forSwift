//
//  MainViewController.swift
//  tableTest
//
//  Created by Andrew Iskandarov on 22.10.2020.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - IBActions

    @IBAction private func getRedWine(_ sender: Any) {
        openWineList(for: .red)
    }

    @IBAction private func gerWhiteWine(_ sender: Any) {
        openWineList(for: .white)
    }

    @IBAction private func getRoseWine(_ sender: Any) {
        openWineList(for: .rose)
    }

    @IBAction private func getAnyWine(_ sender: Any) {
        openWineList(for: .any)
    }

    // MARK: - Private methods

    private func openWineList(for color: WineColor) {
        guard let wineViewController = UIStoryboard(name: String(describing: WineListViewController.self), bundle: Bundle.main)
                .instantiateInitialViewController() as? WineListViewController else {
            fatalError("Please check that WineListViewController is initial View Controller")
        }
        wineViewController.wineColor = color
        navigationController?.pushViewController(wineViewController, animated: true)
    }
}
