//
//  LabelCell.swift
//  YouTubePlaylists
//
//  Created by Olexsii Levchenko on 5/16/22.
//

import UIKit

class LabelCell: UICollectionViewCell {
    
    static let lableIdentifier = "labelCell"
    static let labelID = "label"
    
    public lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    //helper initializer method
    private func commonInit() {
        textLabelConstraints()
    }
    
    func configure(with second: LabelModel) {
        textLabel.text = second.name
    }
    
    private func textLabelConstraints() {
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
    }
}
