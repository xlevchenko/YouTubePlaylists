//
//  Model.swift
//  YouTubePlaylists
//
//  Created by Olexsii Levchenko on 6/1/22.
//

import Foundation

// MARK: - PlaylistResult
struct PlaylistResult: Codable {
    var items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let snippet: Snippet
}

// MARK: - Snippet
struct Snippet: Codable {
    let title: String
    let thumbnails: Thumbnails
    let resourceID: ResourceID

    enum CodingKeys: String, CodingKey {
        case title, thumbnails
        case resourceID = "resourceId"
    }
}

// MARK: - ResourceID
struct ResourceID: Codable {
    let videoID: String

    enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
    }
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    let maxres: Maxres
}

// MARK: - Maxres
struct Maxres: Codable {
    let url: String
}
