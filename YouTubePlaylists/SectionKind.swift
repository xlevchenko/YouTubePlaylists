//
//  SectionKind.swift
//  YouTubePlaylists
//
//  Created by Olexsii Levchenko on 5/15/22.
//

import UIKit


enum SectionKind: Int, CaseIterable {
    case first
    case second
    case third
    
    var columnCount: Int {
        switch self {
        case .first:
            return 1
        case .second:
            return 2
        case .third:
            return 2
        }
    }
    
//    var orthogonalScrolling: NSCollectionLayoutSection {
//        switch self {
//        case .first:
//
//        case .second:
//            <#code#>
//        case .third:
//            <#code#>
//        }
//    }
}
