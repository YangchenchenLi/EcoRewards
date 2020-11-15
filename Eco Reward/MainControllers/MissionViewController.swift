//
//  MissionViewController.swift
//  Eco Reward
//
//  Created by Yang Xu on 16/10/20.
//
//  Code adapted from iOS Academy by Afraz Siddiqui
//  Source: (https://www.youtube.com/playlist?list=PL5PR3UyfTWvdlk-Qi-dPtJmjTj-2YIMMf)

import UIKit
import SwiftUI


class MissionViewController: UIViewController {
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.prefersLargeTitles = false
        
        //firstView.alpha = 1
        navigationController?.navigationBar.barTintColor = UIColor(red: 83/255, green: 181/255, blue: 96/255, alpha: 1)
        


    }

    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            firstView.alpha = 1
            secondView.alpha = 0
            thirdView.alpha = 0
        }
        else if sender.selectedSegmentIndex == 1 {
            firstView.alpha = 0
            secondView.alpha = 1
            thirdView.alpha = 0
        }
        else if sender.selectedSegmentIndex == 2 {
            firstView.alpha = 0
            secondView.alpha = 0
            thirdView.alpha = 1
        }
    }
 
    
    
    
    
        
        
//        let swiftUIController = UIHostingController(rootView: MissionView())
//        self.addChild(swiftUIController)
//        swiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(swiftUIController.view)
//        swiftUIController.didMove(toParent: self)
//        swiftUIController.view.frame = UIScreen.main.bounds
//        swiftUIController.view.backgroundColor = .blue
//        
//        swiftUIController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        swiftUIController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
   
        
}



