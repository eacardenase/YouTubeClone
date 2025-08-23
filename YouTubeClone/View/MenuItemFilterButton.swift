//
//  MenuItemFilterButton.swift
//  YouTubeClone
//
//  Created by Edwin Cardenas on 8/23/25.
//

import UIKit

class MenuItemFilterButton: UIButton {

    // MARK: - Initializers

    init(title: String) {
        super.init(frame: .zero)

        var config = UIButton.Configuration.gray()
        config.cornerStyle = .medium

        configuration = config

        translatesAutoresizingMaskIntoConstraints = false
        
        setTitle(title, for: .normal)
        setTitleColor(.label, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
