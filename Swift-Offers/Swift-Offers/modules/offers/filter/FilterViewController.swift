//
//  FilterViewController.swift
//  Swift-Offers
//
//  Created by Chris Allinson on 2018-07-14.
//  Copyright © 2018 Chris Allinson. All rights reserved.
//

import UIKit


protocol FilterViewControllerOutput: class {
    func filterBySegmentChanged(_ option: SortByOption)
    func filterTextfieldChanged(_ option: String)
    func filterCancelPressed()
}


// MARK: -

class FilterViewController: UIViewController {
    
    // MARK: instance variables
    
    weak var delegate: FilterViewControllerOutput?
    
    var tapGesture: UITapGestureRecognizer?
    
    @IBOutlet var filterTextTextfield: UITextField?
    
    
    
    // MARK: lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(tapGesture!)
    }
    
    deinit {
        tapGesture?.removeTarget(self, action: #selector(viewTapped))
    }
    
    
    
    // MARK: UI Events
    
    @IBAction func filterBySegmentChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                delegate?.filterBySegmentChanged(.name)
            case 1:
                delegate?.filterBySegmentChanged(.description)
            default:
                delegate?.filterBySegmentChanged(.price)
        }
    }
    
    @IBAction func textFieldEditingChanged(_ sender: Any) {
        delegate?.filterTextfieldChanged((sender as! UITextField).text!)
    }
    
    
    
    // MARK: private methods
    
    @objc
    private func viewTapped(sender: UITapGestureRecognizer) {
        let tappedView = sender.view?.hitTest(sender.location(in: self.view), with: nil)
        guard tappedView?.tag == 0 else {
            return
        }
        
        delegate?.filterCancelPressed()
    }
}
