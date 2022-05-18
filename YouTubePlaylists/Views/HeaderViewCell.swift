//
//  HeaderViewCell.swift
//  YouTubePlaylists
//
//  Created by Olexsii Levchenko on 5/15/22.
//

import UIKit

class HeaderViewCell: UICollectionViewCell {
        
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image")
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let playButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "button"), for: .normal)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    let channelNameLable: UILabel = {
        let label = UILabel()
        label.text = "EminemMusic"
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 1
        return label
    }()
    
    let countFollowersLable: UILabel = {
        let label = UILabel()
        label.text = "203 071 followers"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with first: HeaderSectionModel) {
        imageView.image = first.image
        //playButton.
        channelNameLable.text = first.channelNameLable
        countFollowersLable.text = first.countFollowersLable
        
    }
    
    
    
    private func imageViewConstraints() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.addSubview(channelNameLable)
        channelNameLable.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.addSubview(countFollowersLable)
        countFollowersLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            playButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 15),
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            playButton.heightAnchor.constraint(equalToConstant: 60),
            playButton.widthAnchor.constraint(equalToConstant: 60),
            
            channelNameLable.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 85),
            channelNameLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            channelNameLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            countFollowersLable.topAnchor.constraint(equalTo: channelNameLable.bottomAnchor),
            countFollowersLable.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 15),
            countFollowersLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
}
