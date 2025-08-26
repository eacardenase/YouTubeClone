//
//  HomeViewController.swift
//  YouTubeClone
//
//  Created by Edwin Cardenas on 8/18/25.
//

import UIKit

class HomeViewController: UIViewController {

    enum MenuItem: Int, CaseIterable {
        case home
        case videos
        case shorts
        case playlists
        case posts
    }

    // MARK: - Properties

    let homeHeaderView = HomeViewHeader()
    var homeHeaderViewTopConstraint = NSLayoutConstraint()

    lazy var menuBar: MenuBar = {
        let menu = MenuBar()

        menu.delegate = self

        return menu
    }()

    let divider: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .separator

        return view
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0

        let collection = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )

        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .systemBackground
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.register(
            MenuItemCell.self,
            forCellWithReuseIdentifier: NSStringFromClass(MenuItemCell.self)
        )

        return collection
    }()

    let colors: [UIColor] = [
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

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

}

// MARK: - Helpers

extension HomeViewController {

    private func setupViews() {
        view.addSubview(homeHeaderView)
        view.addSubview(menuBar)
        view.addSubview(divider)
        view.addSubview(collectionView)

        homeHeaderViewTopConstraint = homeHeaderView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor
        )

        // homeHeaderView
        NSLayoutConstraint.activate([
            homeHeaderViewTopConstraint,
            homeHeaderView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            homeHeaderView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            ),

        ])

        // menuBar
        NSLayoutConstraint.activate([
            menuBar.topAnchor.constraint(
                equalTo: homeHeaderView.bottomAnchor,
                constant: 16
            ),
            menuBar.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            menuBar.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),
        ])

        // divider
        NSLayoutConstraint.activate([
            divider.topAnchor.constraint(equalTo: menuBar.bottomAnchor),
            divider.leadingAnchor.constraint(equalTo: menuBar.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: menuBar.trailingAnchor),
            divider.heightAnchor.constraint(equalToConstant: 0.5),
        ])

        // collectionView
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: divider.bottomAnchor),
            collectionView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
        ])
    }

}

// MARK: - MenuBarDelegate

extension HomeViewController: MenuBarDelegate {

    func didSelectItemAt(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)

        collectionView.scrollToItem(at: indexPath, at: [], animated: true)

        menuBar.selectItem(at: index)
    }

}

// MARK: - UIScrollViewDelegate

extension HomeViewController: UIScrollViewDelegate {

    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let index = targetContentOffset.pointee.x / view.frame.width

        menuBar.selectItem(at: Int(index))
    }

}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return colors.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NSStringFromClass(MenuItemCell.self),
                for: indexPath
            ) as? MenuItemCell
        else {
            fatalError("Could not initialize MenuItemCell")
        }

        cell.contentItems = colors
        cell.delegate = self

        return cell
    }

}

// MARK: - MenuItemCellDelegate

extension HomeViewController: MenuItemCellDelegate {

    func didScroll(to offset: CGPoint) {
//        let y = offset.y
//
//        let headerViewHeight = homeHeaderView.frame.height
//        let menuBarHeight = menuBar.frame.height
//
//        let swipingDown = y <= 0
//        let shouldSnapHeader = y > 0
//
//        UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
////            self.homeHeaderView.alpha = swipingDown ? 1.0 : 0.0
//            
//            self.homeHeaderViewTopConstraint.constant =
//                shouldSnapHeader ? -headerViewHeight : 0
//            
//            self.collectionView.updateConstraints()
//
//            self.view.layoutIfNeeded()
//        }.startAnimation()
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: collectionView.frame.width,
            height: collectionView.frame.height
        )
    }

}
