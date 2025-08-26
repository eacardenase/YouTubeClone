//
//  HomeViewHeader.swift
//  YouTubeClone
//
//  Created by Edwin Cardenas on 8/23/25.
//

import UIKit

class HomeViewHeader: UIView {

    // MARK: - Properties

    let channelBanner: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "channels4_banner"))

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        return imageView
    }()

    let profileView = ProfileView()

    let profileDescription: UILabel = {
        let label = UILabel()

        let attributedText = NSMutableAttributedString(
            string: """
                Videos that teach 8-bit hardware and software hacking \
                by way of the original Nintendo Entertainment System. 
                """,
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .caption1),
                .foregroundColor: UIColor.secondaryLabel,
            ]
        )

        guard
            let fontDescriptor: UIFontDescriptor = .preferredFontDescriptor(
                withTextStyle: .caption1
            ).withSymbolicTraits(.traitBold)
        else {
            fatalError("Could not create font descriptor with bold trait")
        }

        attributedText.append(
            NSAttributedString(
                string: "...more",
                attributes: [
                    .font: UIFont(descriptor: fontDescriptor, size: 0),
                    .foregroundColor: UIColor.label,
                ]
            )
        )

        label.attributedText = attributedText
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    let subscribeButton: UIButton = {
        let button = UIButton(type: .custom)

        var config = UIButton.Configuration.gray()
        config.cornerStyle = .capsule
        config.imagePadding = 8
        config.image = UIImage(
            systemName: "bell.slash",
            withConfiguration: UIImage.SymbolConfiguration(scale: .medium)
        )?.withTintColor(
            .label,
            renderingMode: .alwaysOriginal
        )

        button.configuration = config
        button.contentHorizontalAlignment = .center

        guard
            let fontDescriptor: UIFontDescriptor = .preferredFontDescriptor(
                withTextStyle: .footnote
            ).withSymbolicTraits(.traitBold)
        else {
            fatalError("Could not create font descriptor with bold trait")
        }

        let attributedText = NSAttributedString(
            string: "Subscribed",
            attributes: [
                .font: UIFont(descriptor: fontDescriptor, size: 0),
                .foregroundColor: UIColor.label,
            ]
        )

        button.setAttributedTitle(attributedText, for: .normal)

        return button
    }()

    let communityButton: UIButton = {
        let button = UIButton(type: .custom)

        var config = UIButton.Configuration.gray()
        config.cornerStyle = .capsule

        button.configuration = config

        guard
            let fontDescriptor: UIFontDescriptor = .preferredFontDescriptor(
                withTextStyle: .footnote
            ).withSymbolicTraits(.traitBold)
        else {
            fatalError("Could not create font descriptor with bold trait")
        }

        let attributedText = NSAttributedString(
            string: "Visit Community",
            attributes: [
                .font: UIFont(descriptor: fontDescriptor, size: 0),
                .foregroundColor: UIColor.label,
            ]
        )

        button.setAttributedTitle(attributedText, for: .normal)
        button.tintColor = .label
        button.titleLabel?.font = .preferredFont(
            forTextStyle: .extraLargeTitle2
        )

        return button
    }()

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Helpers

extension HomeViewHeader {

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false

        let buttonStack = UIStackView(arrangedSubviews: [
            subscribeButton,
            communityButton,
        ])

        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 8

        let stackView = UIStackView(arrangedSubviews: [
            channelBanner,
            profileView,
            profileDescription,
            buttonStack,
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12

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
