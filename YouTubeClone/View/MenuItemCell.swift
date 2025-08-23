//
//  MenuItemCell.swift
//  YouTubeClone
//
//  Created by Edwin Cardenas on 8/19/25.
//

import UIKit

class MenuItemCell: UICollectionViewCell {

    // MARK: - Properties

    let contentItems: [UIColor] = [
        .systemRed,
        .systemGreen,
        .systemBlue,
        .systemPink,
        .systemYellow,
        .systemRed,
        .systemGreen,
        .systemBlue,
        .systemPink,
        .systemYellow,
        .systemRed,
        .systemGreen,
        .systemBlue,
        .systemPink,
        .systemYellow,
        .systemRed,
        .systemGreen,
        .systemBlue,
        .systemPink,
        .systemYellow,
    ]

    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()

        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .vertical

        return layout
    }()

    lazy var collectionView: UICollectionView = {

        let _collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: self.flowLayout
        )

        _collectionView.translatesAutoresizingMaskIntoConstraints = false
        _collectionView.backgroundColor = .systemBackground
        _collectionView.delegate = self
        _collectionView.dataSource = self
        _collectionView.register(
            MenuContentCell.self,
            forCellWithReuseIdentifier: NSStringFromClass(MenuContentCell.self)
        )

        return _collectionView
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

extension MenuItemCell {

    private func setupViews() {
        addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

}

// MARK: - UICollectionViewDelegate

extension MenuItemCell: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDataSource

extension MenuItemCell: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return contentItems.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NSStringFromClass(MenuContentCell.self),
                for: indexPath
            ) as? MenuContentCell
        else {
            fatalError("Could not instantiate MenuContentCell")
        }

        cell.backgroundColor = contentItems[indexPath.item]

        return cell
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension MenuItemCell: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 3
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing

        let width = collectionView.bounds.width
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)

        return CGSize(width: itemDimension, height: itemDimension * 1.5)
    }

}
