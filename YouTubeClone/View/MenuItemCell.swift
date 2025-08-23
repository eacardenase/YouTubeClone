//
//  MenuItemCell.swift
//  YouTubeClone
//
//  Created by Edwin Cardenas on 8/19/25.
//

import UIKit

class MenuItemCell: UICollectionViewCell {

    // MARK: - Properties

    var contentItems: [UIColor] = []

    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()

        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .vertical

        return layout
    }()

    let compositionalLayout: UICollectionViewCompositionalLayout = {
        let fraction: CGFloat = 1 / 3

        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(fraction),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let inset: CGFloat = 0.5

        item.contentInsets = NSDirectionalEdgeInsets(
            top: inset,
            leading: inset,
            bottom: inset,
            trailing: inset
        )

        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(0.5)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )

        // Section
        let section = NSCollectionLayoutSection(group: group)

        return UICollectionViewCompositionalLayout(section: section)
    }()

    lazy var collectionView: UICollectionView = {

        let _collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: self.compositionalLayout
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
