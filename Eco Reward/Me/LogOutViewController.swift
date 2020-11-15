//
//  ProfileViewController.swift
//  Eco Reward
//
//  Created by Yang Xu on 14/10/20.
//
//  Code adapted from AppStuff by Stephan Dowless
//  Source: (https://www.youtube.com/watch?v=WqPoFzVrLj8)


import UIKit
import FirebaseAuth

class LogOutViewController: UIViewController {
    
    
    

    let logOutButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sign Out"

        
        logOutButton.setTitle("Confirm to Sign Out", for: .normal)
        logOutButton.backgroundColor = .systemGray
        logOutButton.setTitleColor(.black, for: .normal)
        logOutButton.frame = CGRect(x: 100, y: 600, width: 200, height: 52)
        view.addSubview(logOutButton)
        
        logOutButton.addTarget(self, action: #selector(didTapLogOutButton), for: .touchUpInside)
    }
    
    // handle the tap action for logout button
    @objc private func didTapLogOutButton() {
        
        // create a confirmation pop-up
        let actionSheet = UIAlertController(title: "",
                                            message: "",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Confirm",
                                            style: .destructive,
                                            handler: { [weak self]_ in
            
            guard let strongSelf = self else {
                return
            }
            
            do {
                try FirebaseAuth.Auth.auth().signOut()
                
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                strongSelf.present(nav, animated: true)
            }
            catch {
                print("Failed to log out")
            }
            
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        
        present(actionSheet, animated: true)
        
        
    }
}
