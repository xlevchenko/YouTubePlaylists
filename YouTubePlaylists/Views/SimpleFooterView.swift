//
//  SimpleFooterView.swift
//  YouTubePlaylists
//
//  Created by Olexsii Levchenko on 5/17/22.
//

import UIKit

class SimpleFooterView: UICollectionReusableView {
    
    private var viewPlayer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9333, green: 0.2588, blue: 0.4902, alpha: 1)
        view.layer.cornerRadius = 16
        return view
    }()
    
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
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    private func setupView() {
        addSubview(viewPlayer)
        viewPlayer.addSubview(openPlayer)
        
        NSLayoutConstraint.activate([
            viewPlayer.topAnchor.constraint(equalTo: topAnchor, constant: 70),
            viewPlayer.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: viewPlayer.trailingAnchor),
            bottomAnchor.constraint(equalTo: viewPlayer.bottomAnchor, constant: -90),
            
            openPlayer.topAnchor.constraint(equalTo: viewPlayer.topAnchor, constant: 5),
            openPlayer.trailingAnchor.constraint(equalTo: viewPlayer.trailingAnchor),
            openPlayer.leadingAnchor.constraint(equalTo: viewPlayer.leadingAnchor)
        ])
    }
}
