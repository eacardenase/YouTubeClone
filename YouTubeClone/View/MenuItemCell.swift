//
//  MenuItemCell.swift
//  YouTubeClone
//
//  Created by Edwin Cardenas on 8/19/25.
//

import UIKit

protocol MenuItemCellDelegate: AnyObject {

    func didScroll(to offset: CGPoint)

}

class MenuItemCell: UICollectionViewCell {

    // MARK: - Properties

    weak var delegate: MenuItemCellDelegate?

    var contentItems: [UIColor] = []

    var menuFilterView: MenuItemFilter?

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

        let headerItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.8),
            heightDimension: .estimated(100)
        )
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerItemSize,
            elementKind: UICollectionView
                .elementKindSectionHeader,
            alignment: .topLeading
        )
        section.boundarySupplementaryItems = [headerItem]

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
        _collectionView.register(
            MenuItemFilter.self,
            forSupplementaryViewOfKind: UICollectionView
                .elementKindSectionHeader,
            withReuseIdentifier: NSStringFromClass(MenuItemFilter.self)
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
        contentView.addSubview(collectionView)

        // collectionView
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
        ])
    }

}

// MARK: - UICollectionViewDelegate

extension MenuItemCell: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDataSource

extension MenuItemCell: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: NSStringFromClass(MenuItemFilter.self),
            for: indexPath
        ) as? MenuItemFilter {
            sectionHeader.delegate = self

            menuFilterView = sectionHeader

            return sectionHeader
        }

        return UICollectionReusableView()
    }

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

// MARK: - MenuItemFilterDelegate

extension MenuItemCell: MenuItemFilterDelegate {

    func didSelectFilterAt(index: Int) {
        menuFilterView?.selectFilter(at: index)
    }

}

// MARK: - UIScrollViewDelegate

extension MenuItemCell: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.didScroll(to: scrollView.contentOffset)
    }

}
