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

    let indicator: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white

        return view
    }()

    let separator: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .separator

        return view
    }()

    var indicatorWidthConstraint = NSLayoutConstraint() {
        didSet {
            oldValue.isActive = false
            indicatorWidthConstraint.isActive = true
        }
    }
    var indicatorXConstraint = NSLayoutConstraint() {
        didSet {
            oldValue.isActive = false
            indicatorXConstraint.isActive = true
        }
    }

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setAlpha(for: homeButton)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        addSubview(indicator)
        addSubview(separator)

        // stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
        ])

        // indicator
        NSLayoutConstraint.activate([
            indicator.topAnchor.constraint(
                equalTo: stackView.bottomAnchor,
                constant: 8
            ),
            indicator.heightAnchor.constraint(equalToConstant: 2),
        ])

        indicatorWidthConstraint = indicator.widthAnchor.constraint(
            equalTo: homeButton.widthAnchor
        )
        indicatorXConstraint = indicator.centerXAnchor.constraint(
            equalTo: homeButton.centerXAnchor
        )

        // separator
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: indicator.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1.5),
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

            self.indicatorWidthConstraint = self.indicator.widthAnchor
                .constraint(
                    equalTo: button.widthAnchor
                )
            self.indicatorXConstraint = self.indicator.centerXAnchor.constraint(
                equalTo: button.centerXAnchor
            )

            self.layoutIfNeeded()
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
