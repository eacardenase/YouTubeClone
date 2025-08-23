//
//  ProfileView.swift
//  YouTubeClone
//
//  Created by Edwin Cardenas on 8/23/25.
//

import UIKit

class ProfileView: UIView {

    // MARK: - Properties

    let imageHeight: CGFloat = 75

    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "profile_picture"))

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = imageHeight / 2
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
    }()

    let nicknameLabel: UILabel = {
        let label = UILabel()

        label.text = "NesHacker"

        guard
            let fontDescriptor: UIFontDescriptor = .preferredFontDescriptor(
                withTextStyle: .title1
            ).withSymbolicTraits(.traitBold)
        else {
            fatalError("Could not create font descriptor with bold trait.")
        }

        label.font = UIFont(descriptor: fontDescriptor, size: 0)
        label.setContentHuggingPriority(.required, for: .vertical)

        return label
    }()

    let usernameLabel: UILabel = {
        let label = UILabel()

        label.text = "@NesHacker"
        label.font = .preferredFont(forTextStyle: .footnote)

        return label
    }()

    let subscribersCount: UILabel = {
        let label = UILabel()

        label.text = "121K subscribers • 51 videos"
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .secondaryLabel

        return label
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

extension ProfileView {

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [
            nicknameLabel,
            usernameLabel,
            subscribersCount,
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally

        addSubview(profileImageView)
        addSubview(stackView)

        // profileImageView
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            profileImageView.widthAnchor.constraint(
                equalToConstant: imageHeight
            ),
            profileImageView.heightAnchor.constraint(
                equalTo: profileImageView.widthAnchor
            ),
        ])

        // stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            stackView.leadingAnchor.constraint(
                equalTo: profileImageView.trailingAnchor,
                constant: 16
            ),
            stackView.bottomAnchor.constraint(
                equalTo: profileImageView.bottomAnchor
            ),
        ])
    }

}
