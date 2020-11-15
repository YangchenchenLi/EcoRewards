//
//  MissionOneViewController.swift
//  Eco Reward
//
//  Created by Yang Xu on 27/10/20.
//

import UIKit
import SwiftUI

class MissionOneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.viewDidLoad()
        self.navigationItem.title = "Level One Mission"
        
        
        let swiftUIController = UIHostingController(rootView: MissionView1())
        self.addChild(swiftUIController)
        
        // display child view in full screen
        swiftUIController.view.translatesAutoresizingMaskIntoConstraints = true
        self.view.addSubview(swiftUIController.view)
        
        swiftUIController.didMove(toParent: self)
        swiftUIController.view.frame = UIScreen.main.bounds
        swiftUIController.view.backgroundColor = .white
                
        swiftUIController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        swiftUIController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        // Do any additional setup after loading the view.
    }
    

   
}
