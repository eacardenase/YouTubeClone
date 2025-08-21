//
//  MenuBarButton.swift
//  YouTubeClone
//
//  Created by Edwin Cardenas on 8/18/25.
//

import UIKit

class MenuBarButton: UIButton {

    // MARK: - Initializers

    init(title: String) {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        setTitleColor(.label, for: .normal)

        guard
            let fontDescriptor: UIFontDescriptor = .preferredFontDescriptor(
                withTextStyle: .subheadline
            ).withSymbolicTraits(.traitBold)
        else { return }

        titleLabel?.font = UIFont(descriptor: fontDescriptor, size: 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
