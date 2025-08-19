//
//  HomeViewController.swift
//  YouTubeClone
//
//  Created by Edwin Cardenas on 8/18/25.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties

    lazy var menuBar: MenuBar = {
        let menu = MenuBar()

        menu.delegate = self

        return menu
    }()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

}

// MARK: - Helpers

extension HomeViewController {

    private func setupViews() {
        view.addSubview(menuBar)

        // menuBar
        NSLayoutConstraint.activate([
            menuBar.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            menuBar.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            menuBar.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),
        ])
    }

}

// MARK: - MenuBarDelegate

extension HomeViewController: MenuBarDelegate {

    func didSelectItemAt(index: Int) {
        menuBar.selectItem(at: index)
    }

}
