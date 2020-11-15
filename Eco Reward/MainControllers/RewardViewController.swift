//
//  RewardViewController.swift
//  Eco Reward
//
//  Created by Yang Xu on 17/10/20.
//

import UIKit
import SwiftUI

class RewardViewController: UIViewController {

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!

    @IBOutlet var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var blockView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        //navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor(red: 83/255, green: 181/255, blue: 96/255, alpha: 1)
        
        blockView.alpha = 1
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3 ) {
            self.spinner.stopAnimating()
            self.blockView.alpha = 0
            
        }

    }

    @IBAction func switchViews(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            
                firstView.alpha = 1
                secondView.alpha = 0

        }
        else {
            firstView.alpha = 0
            secondView.alpha = 1

        }

    }
}
