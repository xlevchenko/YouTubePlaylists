//
//  PlaylistViewController.swift
//  YouTubePlayList
//
//  Created by Olexsii Levchenko on 5/15/22.
//

import UIKit

class PlaylistViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    typealias DataSource = UICollectionViewDiffableDataSource<SectionKind, Int>
    var dataSource: DataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureCollectionView()
        configureDataSource()
    }
}


//MARK: Configure navigation bar
extension PlaylistViewController {
    private func configureNavigationBar() {
        navigationItem.title = "Playlists"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.standardAppearance = appearance
    }
}


//MARK: Configure CollectionView
extension PlaylistViewController {
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        
        //register cell and reusable view
        collectionView.register(HeaderViewCell.self, forCellWithReuseIdentifier: HeaderViewCell.reuseIdentifier)
        
        collectionView.backgroundColor = #colorLiteral(red: 0.1098, green: 0.1059, blue: 0.149, alpha: 1)
        view.addSubview(collectionView)
    }
}


//MARK: Create CompositionalLayout
extension PlaylistViewController {
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            
            //find out what section we are working with
            guard let sectionType = SectionKind(rawValue: sectionIndex) else { return nil }
            
            //how many colums
            let coulumCount = sectionType.columnCount // 1 or 2
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let coustomSpace: CGFloat = 14
            item.contentInsets = NSDirectionalEdgeInsets(top: coustomSpace, leading: coustomSpace, bottom: coustomSpace, trailing: coustomSpace)
            
            let groupHeight = coulumCount == 0 ? NSCollectionLayoutDimension.absolute(230) : .fractionalWidth(0.5)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: coulumCount)

            let section = NSCollectionLayoutSection(group: group)
            //scroling section
            section.orthogonalScrollingBehavior = .groupPaging
            
            return section
        }
        return layout
    }
}


//MARK: UICollectionViewDiffableDataSource
extension PlaylistViewController {
    private func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            if indexPath.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderViewCell.reuseIdentifier, for: indexPath) as? HeaderViewCell

                return cell
            } else if indexPath.section == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderViewCell.reuseIdentifier, for: indexPath) as? HeaderViewCell
                cell?.backgroundColor = .systemYellow
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderViewCell.reuseIdentifier, for: indexPath) as? HeaderViewCell
                cell?.backgroundColor = .systemYellow
                return cell
            }
        })
        
        var snapShot = NSDiffableDataSourceSnapshot<SectionKind, Int>()
        snapShot.appendSections([.first])
        snapShot.appendItems(Array(1...4), toSection: .first)
        //snapShot.appendItems(Array(6...15), toSection: .second)
        //snapShot.appendItems(Array(16...25), toSection: .third)
        dataSource.apply(snapShot, animatingDifferences: true)
        
    }
}
