//
//  PlaylistViewController.swift
//  YouTubePlayList
//
//  Created by Olexsii Levchenko on 5/15/22.
//

import UIKit
import Combine

class PlaylistViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    typealias DataSource = UICollectionViewDiffableDataSource<SectionItem, Int>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionItem, Int>
    var dataSource: DataSource!
        
    private let pagingInfoSubject = PassthroughSubject<PagingInfo, Never>()

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
        collectionView.register(HeaderViewCell.self, forCellWithReuseIdentifier: HeaderViewCell.headerViewIdentifier)
        collectionView.register(PagingSectionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PagingSectionFooterView.pagingIdentifier)
        collectionView.register(LabelCell.self, forCellWithReuseIdentifier: LabelCell.lableIdentifier)
        collectionView.register(LabelSectionHeadrReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LabelSectionHeadrReusableView.labelSectionIdentifier)
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = #colorLiteral(red: 0.1098, green: 0.1059, blue: 0.149, alpha: 1)
        view.addSubview(collectionView)
    }
}


//MARK: Create CompositionalLayout
extension PlaylistViewController {
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            
            //find out what section we are working with
            guard let sectionType = SectionItem(rawValue: sectionIndex) else { return nil }
            
            //how many colums
            let coulumCount = sectionType.columnCount // 1 or 2
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let coustomSpace: CGFloat = 14
            item.contentInsets = NSDirectionalEdgeInsets(top: coustomSpace, leading: coustomSpace, bottom: coustomSpace, trailing: coustomSpace)
            
            let groupHeight = coulumCount == 0 ? NSCollectionLayoutDimension.absolute(230) : .fractionalWidth(0.65)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: coulumCount)

            let section = NSCollectionLayoutSection(group: group)
            
            //scroling section
            section.orthogonalScrollingBehavior = .groupPaging
            
            //configure the LabelSectionHeadrReusableView
            let labelSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
            let label = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: labelSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .bottom)


            //section.boundarySupplementaryItems = [label]
            
            //configure the PagingSectionFooterView
            let pageFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
            let pageFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: pageFooterSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
            
            section.boundarySupplementaryItems = [pageFooter]
            
            section.visibleItemsInvalidationHandler = { [weak self] (items, offset, env) -> Void in
                guard let self = self else { return }

                let page = round(offset.x / self.view.bounds.width)

                self.pagingInfoSubject.send(PagingInfo(sectionIndex: sectionIndex, currentPage: Int(page)))
            }
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
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderViewCell.headerViewIdentifier, for: indexPath) as? HeaderViewCell

                return cell
            } else if indexPath.section == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCell.lableIdentifier, for: indexPath) as? LabelCell
                cell?.backgroundColor = .systemYellow
                cell?.textLabel.text = "Cell \(itemIdentifier)"
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCell.lableIdentifier, for: indexPath) as? LabelCell
                cell?.textLabel.text = "Cell \(itemIdentifier)"
                cell?.backgroundColor = .systemOrange
                return cell
            }
        })
        
        
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) -> UICollectionReusableView? in
            guard let labelCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LabelSectionHeadrReusableView.labelSectionIdentifier, for: indexPath) as? LabelSectionHeadrReusableView else {
                fatalError("")
            }
            if indexPath.section == 0 {
                labelCell.textLabel.text = "Playlists"

            } else if indexPath.section == 1 {
            labelCell.textLabel.text = "Section 2"

            } else if indexPath.section == 2 {
                labelCell.textLabel.text = "Section 3"

            }
            return labelCell
        }
        
        //configure Supplementary View
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) -> UICollectionReusableView? in
            
            if indexPath.section == 0 {
                guard let pagingFooter = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PagingSectionFooterView.pagingIdentifier, for: indexPath) as? PagingSectionFooterView else {
                    fatalError("Could not dequeue a HeaderView")
                }

                // здесь я что то намудрил
                let itemCount = self.dataSource.snapshot().numberOfItems(inSection: SectionItem(rawValue: indexPath.section) ?? SectionItem.first)
                pagingFooter.configure(with: itemCount)
                pagingFooter.subscribeTo(subject: self.pagingInfoSubject, for: indexPath.section)

                return pagingFooter
            } else if indexPath.section == 1{
                guard let pagingFooter = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PagingSectionFooterView.pagingIdentifier, for: indexPath) as? PagingSectionFooterView else {
                    fatalError("Could not dequeue a HeaderView")
                }
                return pagingFooter
            } else {
                guard let pagingFooter = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PagingSectionFooterView.pagingIdentifier, for: indexPath) as? PagingSectionFooterView else {
                    fatalError("Could not dequeue a HeaderView")
                }
                return pagingFooter
            }
        }
        
        var snapShot = NSDiffableDataSourceSnapshot<SectionItem, Int>()
        snapShot.appendSections([.first, .second, .third])
        snapShot.appendItems(Array(1...4), toSection: .first)
        snapShot.appendItems(Array(5...15), toSection: .second)
        snapShot.appendItems(Array(16...25), toSection: .third)
        dataSource.apply(snapShot, animatingDifferences: true)
        
    }
}
