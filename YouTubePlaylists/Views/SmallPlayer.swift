//
//  SmallPlayer.swift
//  YouTubePlaylists
//
//  Created by Olexsii Levchenko on 5/25/22.
//

import UIKit

class SmallPlayer: UIView {
    
    let openPlayer: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "path"), for: .normal)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 18
        backgroundColor = #colorLiteral(red: 0.9333, green: 0.2588, blue: 0.4902, alpha: 1)
        
        setupView()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(openPlayer)
        
        NSLayoutConstraint.activate([
            openPlayer.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            openPlayer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            openPlayer.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
}
