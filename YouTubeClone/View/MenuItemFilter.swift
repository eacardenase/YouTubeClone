//
//  MenuItemFilter.swift
//  YouTubeClone
//
//  Created by Edwin Cardenas on 8/23/25.
//

import UIKit

protocol MenuItemFilterDelegate: AnyObject {

    func didSelectFilterAt(index: Int)

}

class MenuItemFilter: UIView {

    // MARK: - Properties

    weak var delegate: MenuItemFilterDelegate?

    lazy var latestButton: UIButton = {
        let button = MenuItemFilterButton(title: "Latest")

        button.tag = 0
        button.addTarget(
            self,
            action: #selector(buttonTapped),
            for: .touchUpInside
        )

        return button
    }()
    lazy var popularButton: UIButton = {
        let button = MenuItemFilterButton(title: "Popular")

        button.tag = 1
        button.addTarget(
            self,
            action: #selector(buttonTapped),
            for: .touchUpInside
        )

        return button
    }()
    lazy var oldestButton: UIButton = {
        let button = MenuItemFilterButton(title: "Oldest")

        button.tag = 2
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

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Helpers

extension MenuItemFilter {

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [
            latestButton,
            popularButton,
            oldestButton,
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8

        addSubview(stackView)

        // stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

}

// MARK: - Actions

extension MenuItemFilter {

    @objc func buttonTapped(_ sender: UIButton) {
        delegate?.didSelectFilterAt(index: sender.tag)
    }

}
