//
//  NetworkManager.swift
//  YouTubePlaylists
//
//  Created by Olexsii Levchenko on 5/31/22.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    static let playlistID = "PL8czsbhQP4tuLMvH3PBkAifYrVIq1Phim"
    static let apiKey = "IzaSyDnhu5cBO_Ee0Ey0SVKDTgu_p7396Mkc7o"
     let baseUrl = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(NetworkManager.playlistID)&key=\(NetworkManager.apiKey)"
    

    func fetchHeaderSection(completed: @escaping (PlaylistResult?, Error?) -> Void) {
        let urlString = baseUrl
        
        fetchGenericJSONData(urlString: urlString, completion: completed)
    }
    
    //declare my generic json function here
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            
            if let error = error {
                print("Failed to featch apps", error)
                completion(nil, error )
                return
            }
            
            guard let data = data else { return }
            
            do {
                let socialResult = try JSONDecoder().decode(T.self, from: data)
                completion(socialResult, nil)
            } catch let jsonErr {
                print("Failed to decode json:", jsonErr)
                completion(nil, jsonErr)
            }
        }
        .resume()
    }
}


