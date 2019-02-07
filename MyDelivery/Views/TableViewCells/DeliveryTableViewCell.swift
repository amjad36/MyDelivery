//
//  DeliveryTableViewCell.swift
//  MyDelivery
//
//  Created by Amjad Khan on 31/01/19.
//  Copyright © 2019 Conduent. All rights reserved.
//

import UIKit

class DeliveryTableViewCell: UITableViewCell {

    @IBOutlet weak var packageNameLabel: UILabel!
    @IBOutlet weak var packageImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureWithData(package: Package) {
        self.packageNameLabel.text = package.description + " at " + package.location.address
        self.packageImageView.contentMode = .scaleToFill
        self.packageImageView.loadImageUsingCacheWithURLString(package.imageUrl, placeHolder: UIImage(named: "package")) { (loadImageStatus) in
        }
    }

}
