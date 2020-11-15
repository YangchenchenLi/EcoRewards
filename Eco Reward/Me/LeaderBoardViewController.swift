//
//  LeaderBoardViewController.swift
//  Eco Reward
//
//  Created by Yang Xu on 19/10/20.
//

/* This view controller only acts as a container for the "LeaderListView"
   which is written in SwiftUI */

import UIKit
import SwiftUI


class LeaderBoardViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title = "Leaderboard"
        
        
        let swiftUIController = UIHostingController(rootView: LeaderListView())
        self.addChild(swiftUIController)
        
        // display child view in full screen
        swiftUIController.view.translatesAutoresizingMaskIntoConstraints = true
        self.view.addSubview(swiftUIController.view)
        
        swiftUIController.didMove(toParent: self)
        swiftUIController.view.frame = UIScreen.main.bounds
        swiftUIController.view.backgroundColor = .blue
                
        swiftUIController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        swiftUIController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        

    }
}
