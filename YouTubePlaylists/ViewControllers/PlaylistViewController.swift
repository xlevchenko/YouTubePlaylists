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
        case third(BottomSectionModel)
    }
    
    private var timer: Timer!
    private var currentPage = 0
    private var page = HeaderSectionModel.available.count
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
        generateData(animated: false)
        
        self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
    }
}


//MARK: Configure CollectionView
extension PlaylistViewController {
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        
        //register cell and reusable view
        collectionView.register(HeaderViewCell.self, forCellWithReuseIdentifier: HeaderViewCell.reuseIdentifier)
        collectionView.register(MediumViewCell.self, forCellWithReuseIdentifier: MediumViewCell.reuseIdentifier)
        collectionView.register(BottomViewCell.self, forCellWithReuseIdentifier: BottomViewCell.reuseIdentifier)
        
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
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(190))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        addStandardHeader(toSection: section)

        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
            let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(20))
            let pagingFooterElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
            pagingFooterElement.contentInsets = NSDirectionalEdgeInsets.init(top: 15, leading: 0, bottom: 0, trailing: 0)
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
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0)

        if addHeader {
            addStandardHeader(toSection: section)
        }
        
        return section
    }
    
    
    private func buttomSection(addFooter: Bool = false) -> NSCollectionLayoutSection {
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
            let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
            let footerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)

            footerElement.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 7, bottom: 0, trailing: 7)
            section.boundarySupplementaryItems += [footerElement]
        }
        return section
    }
    
    
    private func addStandardHeader(toSection section: NSCollectionLayoutSection) {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        section.boundarySupplementaryItems += [headerElement]
    }
    
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [unowned self] sectionIndex, layoutEnvironment in
            if sectionIndex == 0 {
                return self.topSection(sectionIndex)
            } else if sectionIndex == 1 {
                return self.mediumSection(addHeader: true)
            } else {
                return self.buttomSection(addFooter: false)
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
                
                return footer
            }
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LabelHeadrView.reuseIdentifier, for: indexPath) as! LabelHeadrView
            
            if indexPath.section == 0 {
                header.configure(with: "Playlist 1")
                header.titleLabel.font = .boldSystemFont(ofSize: 29)
            } else if indexPath.section == 1 {
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
        snapshot.appendItems(BottomSectionModel.available.map(SectionItem.third), toSection: sections[2])
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
            let cell: BottomViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: BottomViewCell.reuseIdentifier, for: indexPath) as! BottomViewCell
            cell.configure(with: third)
            return cell
        }
    }
}



// MARK: UICollectionViewDelegate
extension PlaylistViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard 0...2 ~= indexPath.section else { return }
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        
        let vc: UIViewController?
        
        switch item {
        case .first(let headerSectionModel):
            switch headerSectionModel.playlist {
            case .one:
                vc = PlayerViewController()
            case .two:
                vc = PlayerViewController()
            case .three:
                vc = PlayerViewController()
            case .four:
                vc = PlayerViewController()
            }
            
        case .second(let mediumSectionModel):
            vc = PlayerViewController()
        case .third(let bottomSectionModel):
           vc = PlayerViewController()
        }
        guard let viewController = vc else { return }
        self.present(viewController, animated: true)
    }
}


//MARK: Configure Autoscroll Header View
extension PlaylistViewController {
    
    @objc private func changeImage() {

        if currentPage < HeaderSectionModel.available.count {
            let index = IndexPath.init(item: currentPage, section: 0)
            self.collectionView.scrollToItem(at: index, at: .top, animated: true)
            currentPage += 1
        } else {
            currentPage = 0
            let index = IndexPath.init(item: currentPage, section: 0)
            self.collectionView.scrollToItem(at: index, at: .top, animated: true)
        }
    }
}


