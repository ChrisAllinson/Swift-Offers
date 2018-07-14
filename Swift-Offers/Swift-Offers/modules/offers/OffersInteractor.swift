//
//  OffersInteractor.swift
//  Swift-Offers
//
//  Created by Chris Allinson on 2018-07-13.
//  Copyright (c) 2018 Chris Allinson. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit


protocol OffersBusinessLogic {
    func loadOffers(request: Offers.LoadOffers.Request)
}

protocol OffersDataStore {
    var offers: [Offer] { get set }
}


// MARK: -

class OffersInteractor: OffersDataStore {
    
    // MARK: instance variables
    
    var presenter: OffersPresentationLogic?
    var worker: OffersWorker?
    
    var offers: [Offer] = []
}


// MARK: -

extension OffersInteractor: OffersBusinessLogic {
    
    // MARK: OffersBusinessLogic
    
    func loadOffers(request: Offers.LoadOffers.Request) {
        worker = OffersWorker()
        worker?.fetchOffers() { offers, error in
            if offers != nil {
                self.offers = offers!
            }
            
            let response = Offers.LoadOffers.Response(
                offers: offers,
                error: error
            )
            presenter?.presentOffers(response: response)
        }
    }
}

