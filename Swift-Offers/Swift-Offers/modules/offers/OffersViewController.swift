//
//  OffersViewController.swift
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


protocol OffersDisplayLogic: class {
    func displayOffers(viewModel: Offers.LoadOffers.ViewModel)
    func displayError(viewModel: Offers.LoadOffers.ViewModel)
}


// MARK: -

class OffersViewController: UIViewController {
    
    // MARK: instance variables
    
    var interactor: OffersBusinessLogic?
    var router: (NSObjectProtocol & OffersRoutingLogic & OffersDataPassing)?
    
    @IBOutlet var tableView: UITableView?
    @IBOutlet var spinner: UIActivityIndicatorView?
    @IBOutlet var segue: UIStoryboardSegue?
    
    var offers: [Offer] = []
    
    var currentSortOptions: Offers.SortOptions?
    var sortComponent: SortViewController?
    
    
    
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
        let interactor = OffersInteractor()
        let presenter = OffersPresenter()
        let router = OffersRouter()
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
        
        setInitialSortOptions()
        loadOffers()
    }
    
    
    
    // MARK: UI Events
    
    @IBAction func sortPressed() {
        showSort()
    }
    
    
    
    // MARK: private methods
    
    private func setInitialSortOptions() {
        currentSortOptions = Offers.SortOptions(
            sortBy: .name, sortAscDesc: .ascending
        )
    }
    
    private func loadOffers() {
        let tempRequest = Offers.LoadOffers.Request()
        interactor?.loadOffers(request: tempRequest)
    }
    
    private func sortData() {
        offers = offers.sorted {
            if self.currentSortOptions?.sortAscDesc == .ascending {
                return $0.name < $1.name
            } else {
                return $0.name > $1.name
            }
        }
    }
    
    private func showSort() {
        guard sortComponent == nil else {
            return
        }
        
        sortComponent = SortViewController(nibName: "SortViewController", bundle: nil)
        sortComponent?.delegate = self
        sortComponent?.view.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview((sortComponent?.view)!)
    }
    
    
    
    // MARK: fileprivate methods
    
    fileprivate func refreshTable() {
        sortData()
        tableView?.reloadData()
    }
    
    fileprivate func hideSort() {
        guard sortComponent != nil else {
            return
        }
        
        sortComponent?.view.removeFromSuperview()
        sortComponent = nil
    }
}


// MARK: -

extension OffersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "OfferCell", for: indexPath) as? OfferTableViewCell {
            cell.nameLabel?.text = offers[indexPath.row].name
            cell.descriptionLabel?.text = offers[indexPath.row].description
            cell.priceLabel?.text = "$\(offers[indexPath.row].price)"
            return cell
        }
        return UITableViewCell()
    }
}


// MARK: -

extension OffersViewController: UITableViewDelegate {
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "OfferDetails", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


// MARK: -

extension OffersViewController: SortViewControllerOutput {
    
    // MARK: SortViewControllerOutput
    
    func sortBySegmentChanged(_ option: SortByOption) {
        currentSortOptions?.sortBy = option
        refreshTable()
    }
    
    func sortAscDescSegmentChanged(_ option: SortAscDescOption) {
        currentSortOptions?.sortAscDesc = option
        refreshTable()
    }
    
    func cancelPressed() {
        hideSort()
    }
}


// MARK: -

extension OffersViewController: OffersDisplayLogic {
    
    // MARK: OffersDisplayLogic
    
    func displayOffers(viewModel: Offers.LoadOffers.ViewModel) {
        guard let tempOffers = viewModel.offers else {
            return
        }
        
        offers = tempOffers
        refreshTable()
        
        spinner?.stopAnimating()
    }
    
    func displayError(viewModel: Offers.LoadOffers.ViewModel) {
        //
    }
}
