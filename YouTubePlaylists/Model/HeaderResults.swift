//
//  HeaderResults.swift
//  YouTubePlaylists
//
//  Created by Olexsii Levchenko on 5/17/22.
//

import UIKit

struct HeaderResults: Hashable {
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

extension HeaderResults {
    static let available: [HeaderResults] = [
        HeaderResults(image: UIImage(named: "image")!, channelNameLable: "EminemMusic", countFollowersLable: "203 071 followers", playlist: .one),
        HeaderResults(image: UIImage(named: "image")!, channelNameLable: "50 Cent", countFollowersLable: "203 071 followers", playlist: .two),
        HeaderResults(image: UIImage(named: "image")!, channelNameLable: "Monatik", countFollowersLable: "203 071 followers", playlist: .three),
        HeaderResults(image: UIImage(named: "image")!, channelNameLable: "Drake", countFollowersLable: "203 071 followers", playlist: .four)
    ]
}
