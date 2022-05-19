//
//  MediumSectionModel.swift
//  YouTubePlaylists
//
//  Created by Olexsii Levchenko on 5/18/22.
//

import UIKit


struct MediumSectionModel: Hashable {
    let image: UIImage
    let channelNameLable: String
    let countViews: String
}

extension MediumSectionModel {
    static let available: [MediumSectionModel] = [
    MediumSectionModel(image: UIImage(named: "maxresdefault")!, channelNameLable: "Casey Neistat", countViews: "3,035,400,203 views"),
    MediumSectionModel(image: UIImage(named: "maxresdefault")!, channelNameLable: "EdisonPts", countViews: "1,741,528,248 views"),
    MediumSectionModel(image: UIImage(named: "maxresdefault")!, channelNameLable: "Alexey Arestovych", countViews: "2,035,400,203 views"),
    MediumSectionModel(image: UIImage(named: "maxresdefault")!, channelNameLable: "Erik Grankvist ", countViews: "2,5,400,203 views"),
    MediumSectionModel(image: UIImage(named: "maxresdefault")!, channelNameLable: "Bertram - Craft and Wilderness", countViews: "7,035,400,203 views")
    ]
}
