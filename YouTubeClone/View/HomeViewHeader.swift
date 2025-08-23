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

        return imageView
    }()

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 100)
    }

}

// MARK: - Helpers

extension HomeViewHeader {

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(channelBanner)

        // channelBanner
        NSLayoutConstraint.activate([
            channelBanner.topAnchor.constraint(equalTo: topAnchor),
            channelBanner.leadingAnchor.constraint(equalTo: leadingAnchor),
            channelBanner.trailingAnchor.constraint(equalTo: trailingAnchor),
            channelBanner.heightAnchor.constraint(equalToConstant: 100),
        ])

    }

}
