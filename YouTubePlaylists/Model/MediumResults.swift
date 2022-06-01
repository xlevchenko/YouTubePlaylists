//
//  MediumResults.swift
//  YouTubePlaylists
//
//  Created by Olexsii Levchenko on 5/18/22.
//

import UIKit


struct MediumResults: Hashable {
    let image: UIImage
    let channelNameLable: String
    let countViews: String
}

extension MediumResults {
    static let available: [MediumResults] = [
    MediumResults(image: UIImage(named: "maxresdefault")!, channelNameLable: "Casey Neistat", countViews: "3,035,400,203 views"),
    MediumResults(image: UIImage(named: "maxresdefault")!, channelNameLable: "EdisonPts", countViews: "1,741,528,248 views"),
    MediumResults(image: UIImage(named: "maxresdefault")!, channelNameLable: "Alexey Arestovych", countViews: "2,035,400,203 views"),
    MediumResults(image: UIImage(named: "maxresdefault")!, channelNameLable: "Erik Grankvist ", countViews: "2,5,400,203 views"),
    MediumResults(image: UIImage(named: "maxresdefault")!, channelNameLable: "Bertram - Craft and Wilderness", countViews: "7,035,400,203 views")
    ]
}
