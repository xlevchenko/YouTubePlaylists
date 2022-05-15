//
//  PlaylistViewController.swift
//  YouTubePlayList
//
//  Created by Olexsii Levchenko on 5/15/22.
//

import UIKit

class PlaylistViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        //gonfigure navigation bar
        navigationItem.title = "Playlists"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
}

