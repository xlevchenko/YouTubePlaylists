//
//  BottomSectionModel.swift
//  YouTubePlaylists
//
//  Created by Olexsii Levchenko on 5/19/22.
//

import UIKit

struct BottomSectionModel: Hashable {
    let image: UIImage
    let channelNameLable: String
    let countViews: String
}


extension BottomSectionModel {
    static let available: [BottomSectionModel] = [
        BottomSectionModel(image: UIImage(named: "unnamed")!, channelNameLable: "Casey Neistat", countViews: "3,035,400,203 views"),
        BottomSectionModel(image: UIImage(named: "unnamed")!, channelNameLable: "EdisonPts", countViews: "1,741,528,248 views"),
        BottomSectionModel(image: UIImage(named: "unnamed")!, channelNameLable: "Alexey Arestovych", countViews: "2,035,400,203 views"),
        BottomSectionModel(image: UIImage(named: "unnamed")!, channelNameLable: "Erik Grankvist ", countViews: "2,5,400,203 views"),
        BottomSectionModel(image: UIImage(named: "unnamed")!, channelNameLable: "Bertram - Craft and Wilderness", countViews: "7,035,400,203 views")
    ]
}
