//
//  Models.swift
//  Swift-Offers
//
//  Created by Chris Allinson on 2018-07-14.
//  Copyright © 2018 Chris Allinson. All rights reserved.
//

import Foundation


// MARK: Offer

struct Offer {
    var id: String
    var name: String
    var price: Double
    var imageUrl: String?
    var description: String?
}

struct OfferError {
    var statusCode: Int
    var message: String
}



// MARK: Sort

enum SortByOption {
    case name, description, price
}

enum SortAscDescOption {
    case ascending
    case descending
}
