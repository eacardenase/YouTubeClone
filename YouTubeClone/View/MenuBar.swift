//
//  MenuBar.swift
//  YouTubeClone
//
//  Created by Edwin Cardenas on 8/18/25.
//

import UIKit

protocol MenuBarDelegate: AnyObject {

    func didSelectItemAt(index: Int)

}

class MenuBar: UIView {

    // MARK: - Properties

    weak var delegate: MenuBarDelegate?

    lazy var homeButton: UIButton = {
        let button = MenuBarButton(title: "Home")

        button.tag = 0
        button.addTarget(
            self,
            action: #selector(buttonTapped),
            for: .touchUpInside
        )

        return button
    }()

    lazy var videosButton: UIButton = {
        let button = MenuBarButton(title: "Videos")

        button.tag = 1
        button.addTarget(
            self,
            action: #selector(buttonTapped),
            for: .touchUpInside
        )

        return button
    }()

    lazy var shortsButton: UIButton = {
        let button = MenuBarButton(title: "Shorts")

        button.tag = 2
        button.addTarget(
            self,
            action: #selector(buttonTapped),
            for: .touchUpInside
        )

        return button
    }()

    lazy var playlistsButton: UIButton = {
        let button = MenuBarButton(title: "Playlists")

        button.tag = 3
        button.addTarget(
            self,
            action: #selector(buttonTapped),
            for: .touchUpInside
        )

        return button
    }()

    lazy var postsButton: UIButton = {
        let button = MenuBarButton(title: "Posts")

        button.tag = 4
        button.addTarget(
            self,
            action: #selector(buttonTapped),
            for: .touchUpInside
        )

        return button
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setAlpha(for: homeButton)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 42)
    }

}

// MARK: - Helpers

extension MenuBar {

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [
            homeButton,
            videosButton,
            shortsButton,
            playlistsButton,
            postsButton,
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 24

        addSubview(stackView)

        // stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
        ])
    }

    func selectItem(at index: Int) {
        let button: UIButton

        switch index {
        case 0:
            button = homeButton
        case 1:
            button = videosButton
        case 2:
            button = shortsButton
        case 3:
            button = playlistsButton
        case 4:
            button = postsButton
        default:
            button = homeButton

        }

        UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
            self.setAlpha(for: button)
        }.startAnimation()
    }

    private func setAlpha(for button: UIButton) {
        homeButton.alpha = 0.5
        videosButton.alpha = 0.5
        shortsButton.alpha = 0.5
        playlistsButton.alpha = 0.5
        postsButton.alpha = 0.5

        button.alpha = 1
    }

}

// MARK: - Actions

extension MenuBar {

    @objc func buttonTapped(_ sender: UIButton) {
        delegate?.didSelectItemAt(index: sender.tag)
    }

}
