//
//  PlayerViewController.swift
//  YouTubePlaylists
//
//  Created by Olexsii Levchenko on 5/25/22.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    var containerView: UIView!
    
    var playerContainerView: UIView!
    
    var dismissButton: UIButton!
    
    // Reference for the player view.
    private var playerView: PlayerView!
    // URL for the test video.
    private let videoURL = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        configureContainerView()
        
        configurePlayerContainerView()
        configureDismissButton()
        configurePlayerView()
        playVideo()
        
    }
}


//MARK: Configure UIView
extension PlayerViewController {
    private func configureContainerView() {
        containerView = UIView()
        containerView.layer.cornerRadius = 20
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(red: 0.9333, green: 0.2588, blue: 0.5373, alpha: 1.0).cgColor,
                           UIColor(red: 0.3882, green: 0.0431, blue: 0.9608, alpha: 1.0).cgColor]
        gradient.frame = view.bounds
        gradient.cornerRadius = 20
        containerView.layer.addSublayer(gradient)
        
        //setup constrains
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 78),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}


//MARK: Configure Player Container View
extension PlayerViewController {
    private func configurePlayerContainerView() {
        playerContainerView = UIView()
        playerContainerView.backgroundColor = .black
        
        //setup constrains
        containerView.addSubview(playerContainerView)
        playerContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 50),
            playerContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            playerContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            playerContainerView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func configurePlayerView() {
        playerView = PlayerView()
        
        //setup constrains
        playerContainerView.addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerView.leadingAnchor.constraint(equalTo: playerContainerView.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: playerContainerView.trailingAnchor),
            playerView.heightAnchor.constraint(equalTo: playerContainerView.widthAnchor,multiplier: 16/9),
            playerView.centerYAnchor.constraint(equalTo: playerContainerView.centerYAnchor)
        ])
    }
    
    func playVideo() {
        guard let url = URL(string: videoURL) else { return }
        playerView.play(with: url)
    }
}


//MARK: Configure Dismiss Button
extension PlayerViewController {
    private func configureDismissButton() {
        dismissButton = UIButton(type: .custom)
        dismissButton.setImage(UIImage(named: "dismiss"), for: .normal)
        dismissButton.clipsToBounds = true
        dismissButton.contentMode = .scaleAspectFill
        dismissButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        //setup constrains
        containerView.addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            dismissButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 80),
            dismissButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -80),
            dismissButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true)
    }
}
