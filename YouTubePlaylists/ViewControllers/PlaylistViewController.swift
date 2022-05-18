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
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, SectionItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, SectionItem>
    var dataSource: DataSource!
    
    private let pagingInfoSubject = PassthroughSubject<PagingInfo, Never>()
    
    
    enum SectionItem: Hashable {
        case first(HeaderSectionModel)
        case second(MediumSectionModel)
        case third(LabelModel)
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureCollectionView()
        configureDataSource()
        generateData(animated: false)
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
        collectionView.register(MediumViewCell.self, forCellWithReuseIdentifier: MediumViewCell.reuseIdentifier)
        collectionView.register(LabelCell.self, forCellWithReuseIdentifier: LabelCell.lableIdentifier)
        
        collectionView.register(LabelHeadrView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LabelHeadrView.reuseIdentifier)
        collectionView.register(PagingFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PagingFooterView.reuseIdentifier)
        collectionView.register(SimpleFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SimpleFooterView.reuseIdentifier)
        
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = #colorLiteral(red: 0.1098, green: 0.1059, blue: 0.149, alpha: 1)
        view.addSubview(collectionView)
    }
}


//MARK: Create CompositionalLayout
extension PlaylistViewController {
    private func topSection(_ sectionIndex: Int) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem.withEntireSize()
        item.contentInsets = NSDirectionalEdgeInsets.uniform(size: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20))
        let pagingFooterElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        section.boundarySupplementaryItems += [pagingFooterElement]
        
        section.visibleItemsInvalidationHandler = { [weak self] (items, offset, env) -> Void in
            guard let self = self else { return }
            
            let page = round(offset.x / self.view.bounds.width)
            
            self.pagingInfoSubject.send(PagingInfo(sectionIndex: sectionIndex, currentPage: Int(page)))
        }
        return section
    }
    
    
    private func mediumSection(addHeader: Bool = false) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.uniform(size: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.47), heightDimension: .absolute(90))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous

        if addHeader {
            addStandardHeader(toSection: section)
        }
        
        return section
    }
    
    
    private func buttomSection(itemCont: Int, addFooter: Bool = false) -> NSCollectionLayoutSection {
        //create item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.uniform(size: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalWidth(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        addStandardHeader(toSection: section)
        
        if addFooter {
            let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(35))
            let footerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
            section.boundarySupplementaryItems += [footerElement]
        }
        return section
    }
    
    
    private func addStandardHeader(toSection section: NSCollectionLayoutSection) {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [headerElement]
    }
    
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [unowned self] sectionIndex, layoutEnvironment in
            if sectionIndex == 0 {
                return self.topSection(sectionIndex)
            } else if sectionIndex == 1 {
                
                return self.mediumSection(addHeader: true)
            } else {
                let snapshot = self.dataSource.snapshot()
                let itemCount = snapshot.numberOfItems(inSection: sectionIndex)
                let addFooter = snapshot.numberOfSections == sectionIndex + 1
                return self.buttomSection(itemCont: itemCount, addFooter: addFooter)
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        
        return layout
    }
}


//MARK: UICollectionViewDiffableDataSource
extension PlaylistViewController {
    private func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return self.cell(collectionView: collectionView, indexPath: indexPath, item: itemIdentifier)
        })
        
        dataSource.supplementaryViewProvider = { [unowned self] collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionFooter {
                if indexPath.section == 0 {
                    let pagingFooter = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PagingFooterView.reuseIdentifier, for: indexPath) as! PagingFooterView
                    
                    let itemCount = self.dataSource.snapshot().numberOfItems(inSection: indexPath.section)
                    pagingFooter.configure(with: itemCount)
                    
                    pagingFooter.subscribeTo(subject: pagingInfoSubject, for: indexPath.section)
                    return pagingFooter
                }
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SimpleFooterView.reuseIdentifier, for: indexPath) as! SimpleFooterView
                footer.configure(with: "This example!")
                return footer
            }
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LabelHeadrView.reuseIdentifier, for: indexPath) as! LabelHeadrView
            
            if indexPath.section == 1 {
                header.configure(with: "Playlist 2")
            } else {
                header.configure(with: "Playlist 3")
            }
            return header
        }
    }
    
    
    private func generateData(animated: Bool) {
        var snapshot = Snapshot()
        
        var sections = [Int]()
        
        for i in 0...2 {
            sections.append(i)
        }
        
        snapshot.appendSections(sections)
        
        snapshot.appendItems(HeaderSectionModel.available.map(SectionItem.first), toSection: sections[0])
        snapshot.appendItems(MediumSectionModel.available.map(SectionItem.second), toSection: sections[1])
        snapshot.appendItems(LabelModel.available.map(SectionItem.third), toSection: sections[2])
        
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    
    private func cell(collectionView: UICollectionView, indexPath: IndexPath, item: SectionItem) -> UICollectionViewCell {
        switch item {
        case .first(let first):
            let cell: HeaderViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderViewCell.reuseIdentifier, for: indexPath) as! HeaderViewCell
            cell.configure(with: first)
            return cell
        
        case .second(let second):
            let cell: MediumViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: MediumViewCell.reuseIdentifier, for: indexPath) as! MediumViewCell
            cell.configure(with: second)
            return cell
        
        case .third(let third):
            let cell: LabelCell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCell.lableIdentifier, for: indexPath) as! LabelCell
            cell.configure(with: third)
            cell.backgroundColor = .systemOrange
            return cell
        }
    }
}


// MARK: UICollectionViewDelegate
extension PlaylistViewController: UICollectionViewDelegate {
    
}
