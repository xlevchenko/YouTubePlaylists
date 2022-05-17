//
//  LabelModel.swift
//  YouTubePlaylists
//
//  Created by Olexsii Levchenko on 5/17/22.
//

import UIKit

struct LabelModel: Hashable {
    var name: String
}


extension LabelModel {
    static let available: [LabelModel] = [
        LabelModel(name: "Cell 1"),
        LabelModel(name: "Cell 2"),
        LabelModel(name: "Cell 3"),
        LabelModel(name: "Cell 4"),
        LabelModel(name: "Cell 5"),
        LabelModel(name: "Cell 6"),
        LabelModel(name: "Cell 7")
    ]
}
