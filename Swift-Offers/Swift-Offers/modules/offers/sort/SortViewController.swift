//
//  SortViewController.swift
//  Swift-Offers
//
//  Created by Chris Allinson on 2018-07-14.
//  Copyright © 2018 Chris Allinson. All rights reserved.
//

import UIKit


protocol SortViewControllerOutput: class {
    func sortBySegmentChanged(_ option: SortByOption)
    func sortAscDescSegmentChanged(_ option: SortAscDescOption)
    func cancelPressed()
}


// MARK: -

class SortViewController: UIViewController {
    
    // MARK: instance variables
    
    weak var delegate: SortViewControllerOutput?
    
    var tapGesture: UITapGestureRecognizer?
    
    @IBOutlet var sortBySegment: UISegmentedControl?
    @IBOutlet var ascDescSegment: UISegmentedControl?
    
    
    
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
    
    @IBAction func sortBySegmentChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                delegate?.sortBySegmentChanged(.name)
            case 1:
                delegate?.sortBySegmentChanged(.description)
            default:
                delegate?.sortBySegmentChanged(.price)
        }
    }
    
    @IBAction func sortAscDescSegmentChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                delegate?.sortAscDescSegmentChanged(.ascending)
            default:
                delegate?.sortAscDescSegmentChanged(.descending)
        }
    }
    
    
    
    // MARK: private methods
    
    @objc
    private func viewTapped(sender: UITapGestureRecognizer) {
        let tappedView = sender.view?.hitTest(sender.location(in: self.view), with: nil)
        guard tappedView?.tag == 0 else {
            return
        }
        
        delegate?.cancelPressed()
    }
}
