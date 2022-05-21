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
    
}

extension HeaderSectionModel {
    static let available: [HeaderSectionModel] = [
        HeaderSectionModel(image: UIImage(named: "image")!, channelNameLable: "EminemMusic", countFollowersLable: "203 071 followers"),
        HeaderSectionModel(image: UIImage(named: "image")!, channelNameLable: "50 Cent", countFollowersLable: "203 071 followers"),
        HeaderSectionModel(image: UIImage(named: "image")!, channelNameLable: "Monatik", countFollowersLable: "203 071 followers"),
        HeaderSectionModel(image: UIImage(named: "image")!, channelNameLable: "Drake", countFollowersLable: "203 071 followers")
    ]
}
