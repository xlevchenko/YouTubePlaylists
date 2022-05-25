//
//  ContainerViewController.swift
//  YouTubePlaylists
//
//  Created by Olexsii Levchenko on 5/25/22.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var player = SimpleFooterView()
    
    let playlistConroller = PlaylistViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1098, green: 0.1059, blue: 0.149, alpha: 1)
        miniPlayer()
        addPlaylistCollection()
        
    }
}


//MARK: Configure ContainerView
extension ContainerViewController {
    private func addPlaylistCollection() {
        addChild(playlistConroller)
        view.addSubview(playlistConroller.view)
        configureContainerView()
        playlistConroller.didMove(toParent: self)
    }
    
    private func configureContainerView() {
        playlistConroller.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playlistConroller.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playlistConroller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playlistConroller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playlistConroller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70)
        ])
    }
}


//MARK: Configure PlayerView
extension ContainerViewController {
    private func miniPlayer() {
        view.addSubview(player)
        player.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            player.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            player.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: player.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: player.bottomAnchor, constant: 50),
        ])
    }
}
