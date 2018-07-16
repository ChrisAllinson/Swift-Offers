//
//  Models.swift
//  Swift-Offers
//
//  Created by Chris Allinson on 2018-07-14.
//  Copyright © 2018 Chris Allinson. All rights reserved.
//

import Foundation
import Marshal


// MARK: Offer

struct Offer: Unmarshaling {
    var id: String
    var name: String
    var price: Double
    var imageUrl: String?
    var description: String?
    
    init(object: MarshaledObject) throws {
        id = try object.value(for: "id")
        name = try object.value(for: "name")
        price = try object.value(for: "price")
        imageUrl = try? object.value(for: "imageUrl")
        description = try? object.value(for: "description")
    }
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
