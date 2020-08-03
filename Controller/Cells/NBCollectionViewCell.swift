//
//  NBCollectionViewCell.swift
//  ePocket
//
//  Created by Gokul Nair on 01/08/20.
//  Copyright © 2020 Gokul Nair. All rights reserved.
//

import UIKit

class NBCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLbl:UILabel!
    
    override func awakeFromNib() {
        imageView.layer.cornerRadius = 30
    }
}
