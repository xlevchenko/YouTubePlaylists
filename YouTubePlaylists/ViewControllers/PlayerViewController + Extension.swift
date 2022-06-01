//
//  PlayerViewController + Extension.swift
//  YouTubePlaylists
//
//  Created by Olexsii Levchenko on 5/31/22.
//

import UIKit
import AVFoundation

extension PlayerViewController {
    
    //configure scroll slider
    func scrollVideoSlider() -> UISlider {
        let slider = UISlider()
        slider.maximumTrackTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.35)
        slider.minimumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "line"), for: .normal)
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)

        //setup constrains
        containerView.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: playerContainerView.bottomAnchor, constant: 30),
            slider.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            slider.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
        
        return slider
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
    
    
    func startLabel() -> UILabel {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
        
        //setup constrains
        containerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: videoSlider.bottomAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        return label
    }
    
    
    func finishLabel() -> UILabel {
        let endVideoLengthLabel = UILabel()
        endVideoLengthLabel.text = "00:00"
        endVideoLengthLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)

        //setup constrains
        containerView.addSubview(endVideoLengthLabel)
        endVideoLengthLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            endVideoLengthLabel.topAnchor.constraint(equalTo: videoSlider.bottomAnchor, constant: 10),
            endVideoLengthLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
        
        return endVideoLengthLabel
    }
    
    
    func nameLable() -> UILabel {
        let nameLable = UILabel()
        nameLable.text = "Running Back to NEW YORK CITY"
        nameLable.font = .boldSystemFont(ofSize: 22)
        nameLable.textColor = .white
        nameLable.numberOfLines = 1
        
        containerView.addSubview(nameLable)
        nameLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLable.topAnchor.constraint(equalTo: videoSlider.bottomAnchor, constant: 60),
            nameLable.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        return nameLable
    }
    
    
    func countViewsLabel() -> UILabel {
        let viewLabel = UILabel()
        viewLabel.text = "203 071 views"
        viewLabel.font = .systemFont(ofSize: 17)
        viewLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.75)
        viewLabel.numberOfLines = 1
        
        containerView.addSubview(viewLabel)
        viewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewLabel.topAnchor.constraint(equalTo: nameVideoLable.bottomAnchor, constant: 10),
            viewLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        return viewLabel
    }
    
    
    func prevButton() -> UIButton {
        let previousButton = UIButton()
        previousButton.setImage(UIImage(named: "Prev"), for: .normal)
        
        return previousButton
    }
    
    
    func playPauseButton() -> UIButton {
        let playPauseButton = UIButton()
        playPauseButton.setImage(UIImage(named: "play"), for: .normal)
        playPauseButton.addTarget(self, action: #selector(handlePlayVideo), for: .touchUpInside)
        
        return playPauseButton
    }
    
    @objc func handlePlayVideo() {
        if playerView.player?.rate == 0 {
            playerView.player?.play()
            playPause.setImage(UIImage(named: "Pause"), for: .normal)
            addBoundaryTimeObserver()
        } else {
            playerView.player?.pause()
            playPause.setImage(UIImage(named: "play"), for: .normal)
        }
    }
    
    func nextButton() -> UIButton {
        let nextButton = UIButton()
        nextButton.setImage(UIImage(named: "Next"), for: .normal)
        
        return nextButton
    }
    
    
    func minimumVolume() -> UIImageView {
        let minVolume = UIImageView()
        minVolume.image = UIImage(named: "Sound_Min")
        minVolume.clipsToBounds = true
        minVolume.contentMode = .scaleAspectFill
        
        return minVolume
    }
    
    
    func controlVolumeSlider() -> UISlider {
        let volumeSlider = UISlider()
        volumeSlider.maximumTrackTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.35)
        volumeSlider.minimumTrackTintColor = .white
        volumeSlider.setValue(0.75, animated: true)
        volumeSlider.addTarget(self, action: #selector(handleVolume), for: .valueChanged)
        
        return volumeSlider
    }
    
    
    func maximumVolume() -> UIImageView {
        let maxVolume = UIImageView()
        maxVolume.image = UIImage(named: "Sound_Max")
        maxVolume.clipsToBounds = true
        maxVolume.contentMode = .scaleAspectFill
        
        return maxVolume
    }
    
    @objc func handleVolume() {
        playerView.player?.volume = volumeSlider.value
    }
}


//MARK: Setup Constraint Controls Button and Volume
extension PlayerViewController {
    func setupConstraintButtonControls() {
        let stackView = UIStackView(arrangedSubviews: [previousButton, playPause, nextVideoButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 30
        containerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: viewLabel.bottomAnchor, constant: 30),
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0),
        ])
    }

    
    func setupConstraintVolumeControlrs() {
        let stackView = UIStackView(arrangedSubviews: [minVolume, volumeSlider, maxVolume])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        containerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -150),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
    }
}
