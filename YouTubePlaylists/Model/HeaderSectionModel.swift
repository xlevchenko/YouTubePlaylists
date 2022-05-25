//
//  HeaderSectionModel.swift
//  YouTubePlaylists
//
//  Created by Olexsii Levchenko on 5/17/22.
//

import UIKit

struct HeaderSectionModel: Hashable {
    let image: UIImage
    //let button: UIButton
    let channelNameLable: String
    let countFollowersLable: String
    let playlist: HeaderPlaylist
    
    enum HeaderPlaylist {
        case one
        case two
        case three
        case four
    }
    
}

extension HeaderSectionModel {
    static let available: [HeaderSectionModel] = [
        HeaderSectionModel(image: UIImage(named: "image")!, channelNameLable: "EminemMusic", countFollowersLable: "203 071 followers", playlist: .one),
        HeaderSectionModel(image: UIImage(named: "image")!, channelNameLable: "50 Cent", countFollowersLable: "203 071 followers", playlist: .two),
        HeaderSectionModel(image: UIImage(named: "image")!, channelNameLable: "Monatik", countFollowersLable: "203 071 followers", playlist: .three),
        HeaderSectionModel(image: UIImage(named: "image")!, channelNameLable: "Drake", countFollowersLable: "203 071 followers", playlist: .four)
    ]
}
