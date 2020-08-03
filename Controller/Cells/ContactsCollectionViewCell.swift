//
//  ContactsCollectionViewCell.swift
//  ePocket
//
//  Created by Gokul Nair on 03/08/20.
//  Copyright © 2020 Gokul Nair. All rights reserved.
//

import UIKit

class ContactsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var phoneNolbl: UILabel!
    
    override func awakeFromNib() {
        imageView.layer.cornerRadius = 10
    }
}
