//
//  OfferViewController.swift
//  Swift-Offers
//
//  Created by Chris Allinson on 2018-07-14.
//  Copyright (c) 2018 Chris Allinson. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit


protocol OfferDetailsDisplayLogic: class {
    func displayOffer(viewModel: OfferDetails.LoadOffer.ViewModel)
}


// MARK: -

class OfferDetailsViewController: UIViewController {
    
    // MARK: instance variables
    
    var interactor: OfferDetailsBusinessLogic?
    var router: (NSObjectProtocol & OfferDetailsRoutingLogic & OfferDetailsDataPassing)?
    
    @IBOutlet var navItem: UINavigationItem?
    
    @IBOutlet var offerImage: UIImageView?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var descriptionLabel: UILabel?
    @IBOutlet var priceLabel: UILabel?
    
    
    
    // MARK: object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: setup
    
    private func setup() {
        let viewController = self
        let interactor = OfferDetailsInteractor()
        let presenter = OfferDetailsPresenter()
        let router = OfferDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: view lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadOffer()
    }
    
    
    
    // MARK: private methods
    
    private func loadOffer() {
        let request = OfferDetails.LoadOffer.Request()
        interactor?.loadOffer(request: request)
    }
    
    
    
    // MARK: fileprivate methods
    
    fileprivate func lazyLoadImage() {
        let tempUrl = URL(string: "http://www.allinson.ca/libs/allinson-styleguide/global/images/logo/logo.png")!
        URLSession.shared.dataTask(with: tempUrl) { ( data, response, error) in
            DispatchQueue.main.async {
                let tempImage = UIImage(data: data!)
                self.offerImage?.image = tempImage
            }
        }.resume()
    }
}


// MARK: -

extension OfferDetailsViewController: OfferDetailsDisplayLogic {
    
    // MARK: OfferDisplayLogic
    
    func displayOffer(viewModel: OfferDetails.LoadOffer.ViewModel) {
        navItem?.title = viewModel.offer.name
        
        nameLabel?.text = viewModel.offer.name
        descriptionLabel?.text = viewModel.offer.description
        priceLabel?.text = "$\(viewModel.offer.price)"
        
        lazyLoadImage()
    }
}
