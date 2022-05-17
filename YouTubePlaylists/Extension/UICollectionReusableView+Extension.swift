//
//  UICollectionReusableView+Extension.swift
//  YouTubePlaylists
//
//  Created by Olexsii Levchenko on 5/17/22.
//

import UIKit

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
