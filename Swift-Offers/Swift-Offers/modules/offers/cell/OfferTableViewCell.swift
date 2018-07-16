//
//  OfferTableViewCell.swift
//  Swift-Offers
//
//  Created by Chris Allinson on 2018-07-14.
//  Copyright © 2018 Chris Allinson. All rights reserved.
//

import UIKit


protocol OfferTableViewCellInput {
    func lazyLoadImage(_ imageUrl: String?)
}


// MARK: -

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


// MARK: -

extension OfferTableViewCell: OfferTableViewCellInput {
    
    // MARK: OfferTableViewCellInput
    
    func lazyLoadImage(_ imageUrl: String?) {
        guard imageUrl != nil else {
            return
        }
        
        if let tempUrl = URL(string: imageUrl!) {
            URLSession.shared.dataTask(with: tempUrl) { (data, response, error) in
                DispatchQueue.main.async {
                    let tempImage = UIImage(data: data!)
                    self.offerImage?.image = tempImage
                }
            }.resume()
        }
    }
}
