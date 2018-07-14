//
//  OfferTableViewCell.swift
//  Swift-Offers
//
//  Created by Chris Allinson on 2018-07-14.
//  Copyright © 2018 Chris Allinson. All rights reserved.
//

import UIKit

class OfferTableViewCell: UITableViewCell {
    
    // MARK: instance variables
    
    @IBOutlet var offerImage: UIImageView?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var descriptionLabel: UILabel?
    @IBOutlet var priceLabel: UILabel?
    
    
    
    // MARK: lifecycle methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    // MARK: UI Events
    
    @IBAction func buttonPressed() {
        print("BUTTON PRESSED")
    }
}
