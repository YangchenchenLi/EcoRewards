//
//  ActivatedCollectionViewCell.swift
//  Eco Reward
//
//  Created by Yang Xu on 24/10/20.
//

import UIKit

class ActivatedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    func generateCell(_ item: Item) {
        nameLabel.text = item.name
        imageView.image = item.image
    
    }
}
