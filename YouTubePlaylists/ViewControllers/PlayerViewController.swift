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
    // Reference for the player view.
    var playerView = PlayerView() //mayby needed frame
   
    // URL for the test video.
    private let videoURL = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
    
    var dismissButton: UIButton!
    
    var videoSlider: UISlider!
    var startVideoLengthLabel: UILabel!
    var endVideoLengthLabel: UILabel!
    var addPlayPause: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        configureContainerView()
        configurePlayerContainerView()
        configureDismissButton()
        configurePlayerView()
        playVideo()
        
        configureVideoSlider()
        configureStartVideoLength()
        configureEndVideoLength()
        configureAddPlayPause()
        
    }
}



//MARK: Configure Player
extension PlayerViewController {
    func addBoundaryTimeObserver() {
        playerView.player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 2), queue: DispatchQueue.main) { [weak self] progressTime in
            
            if let duration = self?.playerView.player?.currentItem?.duration {
                let durationSeconds = CMTimeGetSeconds(duration)
                let seconds = CMTimeGetSeconds(progressTime)
                let progress = Float(seconds/durationSeconds)
                
                DispatchQueue.main.async {
                    self?.videoSlider.value = progress
                    if progress >= 1.0 {
                        self?.videoSlider.value = 0.0
                    }
                }
            }
            
            if let duration = self?.playerView.player?.currentItem?.duration {
                let totalSeconds = CMTimeGetSeconds(duration)
                //change endLable
                let secondsText = Int(totalSeconds) % 60
                let minutesText = String(format: "%02d", Int(totalSeconds) / 60)
                self?.endVideoLengthLabel.text = "\(minutesText):\(secondsText)"
            }
            
            let seconds = CMTimeGetSeconds(progressTime)
            let secondString = String(format: "%02d", Int(seconds) % 60)
            let minutesText = String(format: "%02d", Int(seconds) / 60)
            self?.startVideoLengthLabel.text = "\(minutesText):\(secondString)"
        }
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

        //setup constrains
        playerContainerView.addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            playerView.leadingAnchor.constraint(equalTo: playerContainerView.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: playerContainerView.trailingAnchor),
            playerView.heightAnchor.constraint(equalTo: playerContainerView.widthAnchor, multiplier: 16/9),
            playerView.centerYAnchor.constraint(equalTo: playerContainerView.centerYAnchor)
        ])
    }
    
    func playVideo() {
        guard let url = URL(string: videoURL) else { return }
        playerView.play(with: url)
        
        
        
    }
}


extension PlayerViewController {
    private func configureVideoSlider() {
        videoSlider = UISlider()
        videoSlider.maximumTrackTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.35)
        videoSlider.minimumTrackTintColor = .white
        videoSlider.setThumbImage(UIImage(named: "line"), for: .normal)
        videoSlider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)

        //setup constrains
        containerView.addSubview(videoSlider)
        videoSlider.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            videoSlider.topAnchor.constraint(equalTo: playerContainerView.bottomAnchor, constant: 30),
            videoSlider.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            videoSlider.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
    }

    
    @objc func handleSliderChange() {
        
        if let duration = playerView.player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Float64(videoSlider.value) * totalSeconds
            let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
            playerView.player?.seek(to: seekTime, completionHandler: { completedSeek in
                //do something later
            })
        }
    }

    
    func configureStartVideoLength() {
        startVideoLengthLabel = UILabel()
        startVideoLengthLabel.text = "00:00"
        startVideoLengthLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)


        //setup constrains
        containerView.addSubview(startVideoLengthLabel)
        startVideoLengthLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            startVideoLengthLabel.topAnchor.constraint(equalTo: videoSlider.bottomAnchor, constant: 10),
            startVideoLengthLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }

    func configureEndVideoLength() {
        endVideoLengthLabel = UILabel()
        endVideoLengthLabel.text = "00:00"
        endVideoLengthLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)

        //setup constrains
        containerView.addSubview(endVideoLengthLabel)
        endVideoLengthLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            endVideoLengthLabel.topAnchor.constraint(equalTo: videoSlider.bottomAnchor, constant: 10),
            endVideoLengthLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func configureAddPlayPause() {
        addPlayPause = UIButton()
        addPlayPause.setImage(UIImage(named: "play"), for: .normal)
        addPlayPause.addTarget(self, action: #selector(handlePlayVideo), for: .touchUpInside)
        
        containerView.addSubview(addPlayPause)
        addPlayPause.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addPlayPause.topAnchor.constraint(equalTo: startVideoLengthLabel.bottomAnchor, constant: 10),
            addPlayPause.trailingAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func handlePlayVideo() {
        playerView.player?.play()
        addBoundaryTimeObserver()
    }
}



