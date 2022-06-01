//
//  MediumViewCell.swift
//  YouTubePlaylists
//
//  Created by Olexsii Levchenko on 5/18/22.
//

import UIKit

class MediumViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "unnamed")
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let channelNameLable: UILabel = {
        let label = UILabel()
        label.text = "Casey Neistat"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    let countViewsLable: UILabel = {
        let label = UILabel()
        label.text = "203 071 views"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
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
    
    
    func configure(with medium: MediumResults) {
        imageView.image = medium.image
        channelNameLable.text = medium.channelNameLable
        countViewsLable.text = medium.countViews
    }
    
    private func imageViewConstraints() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        addSubview(channelNameLable)
        channelNameLable.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(countViewsLable)
        countViewsLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor),
                 
            channelNameLable.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            channelNameLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            channelNameLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            countViewsLable.topAnchor.constraint(equalTo: channelNameLable.bottomAnchor, constant: 4),
            countViewsLable.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 15),
            countViewsLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
    
}
