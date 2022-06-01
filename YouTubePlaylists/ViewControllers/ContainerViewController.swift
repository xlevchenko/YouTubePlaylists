//
//  ContainerViewController.swift
//  YouTubePlaylists
//
//  Created by Olexsii Levchenko on 5/25/22.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var player = SmallPlayer()
    
    let playlistConroller = PlaylistViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1098, green: 0.1059, blue: 0.149, alpha: 1)
        miniPlayer()
        addPlaylistCollection()
        
        player.openPlayer.addTarget(self, action: #selector(handle(sender: )), for: .touchUpInside)
    }
    
    @objc func handle(sender: UIButton!) {
        let controller = PlayerViewController()
        present(controller, animated: true)
    }
}


//MARK: - Configure ContainerView
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
            playlistConroller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
        ])
    }
}


//MARK: - Configure PlayerView
extension ContainerViewController {
    private func miniPlayer() {
        view.addSubview(player)
        player.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            player.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            player.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            player.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            player.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
