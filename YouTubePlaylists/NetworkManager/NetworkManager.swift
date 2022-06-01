//
//  NetworkManager.swift
//  YouTubePlaylists
//
//  Created by Olexsii Levchenko on 5/31/22.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseUrl = "https://www.googleapis.com/youtube/v3/playlistItems"
    private let apiKey = "AIzaSyDnhu5cBO_Ee0Ey0SVKDTgu_p7396Mkc7o"
    
    private init() { }
}
