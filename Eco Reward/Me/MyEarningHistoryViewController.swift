//
//  MyAchievementViewController.swift
//  Eco Reward
//
//  Created by Yang Xu on 19/10/20.
//

import UIKit
import SwiftUI

class MyEarningHistoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "My Earning History"

        let swiftUIController = UIHostingController(rootView: EarningListView())
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

