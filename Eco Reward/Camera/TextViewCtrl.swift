//
//  TextViewCtrl.swift
//  QRtest
//
//  Created by Yiwei Gao on 2020/10/16.
//  Editor: Yiwei Gao, Yang Xu.
//  Copyright © 2020 YiweiGao. All rights reserved.
//

import UIKit

class TextViewCtrl: UIViewController {
    
    var text : NSString!
    var totalStr : String!
    var info : [String] = ["","","",""]
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // seperate the content and put them into an array
        let arrayStrings = text.components(separatedBy: "\n")
                
        var text_y = 100
        
        // iterate the arrayStrings and send the result to view
        for idx in 0...arrayStrings.count {
            if idx % 2 != 0 {
                
                let title = UILabel.init(frame: CGRect(x:15, y: 20, width: 150, height: 25))
                let label = UILabel.init(frame: CGRect(x: 50, y: text_y, width: 150, height: 30))
                let label_2 = UILabel.init(frame: CGRect(x: 300, y: text_y, width: 150, height:30))
                
                self.view.addSubview(label)
                
                self.view.addSubview(label_2)
                self.view.addSubview(title)
                
                label.text = arrayStrings[idx-1]
                label_2.text = arrayStrings[idx]
                title.text = "Green Rating"
                
                
                title.font = title.font.withSize(30)
                label.font = label.font.withSize(15)
                label_2.font = label_2.font.withSize(15)
                
                //text_y = text_y + 40
                text_y = text_y + 40
                
             
                // put the value of total items, total credits and total to info array
                if arrayStrings[idx-1] == "Date" {
                    totalStr = arrayStrings[idx]
                    info[0] = totalStr
                } else if arrayStrings[idx-1] == "Total Items"{
                    totalStr = arrayStrings[idx]
                    info[1] = totalStr
                } else if arrayStrings[idx-1] == "Total Credits" {
                    totalStr = arrayStrings[idx]
                    info[2] = totalStr
                } else if arrayStrings[idx-1] == "Total" {
                    totalStr = arrayStrings[idx]
                    info[3] = totalStr
                }
            }
        }
        
    }
    
    
// MARK: - Actions after the user click the "redeem" button
    
    // Response to click action
    @IBAction func ecportAction(_ sender: UIButton) {
        
        // create a confirmation pop-up
        let points = info[2]
        let bonusPoints = computeBonusPoints(record: info)
    
        print(bonusPoints)
        
        let message = "\(points) points and \(bonusPoints) bonus points will be added to your account."
        let actionSheet = UIAlertController(title: "Congradulations!",
                                            message: message,
                                            preferredStyle: .actionSheet)
        
        let plus = Double(points)
        let bonusPlus = Double(points)
        
        actionSheet.addAction(UIAlertAction(title: "Confirm",
                                            style: .destructive,
                                            handler: { action in
                                                
                                                // adding points to the user account
                                                updatePoints(points: plus! + bonusPlus!)
                                                addNewRecord(record: self.info)
                                                
                                                // confirmation
                                                self.agreeTo()
                                            }
                                            
        ))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        
        present(actionSheet, animated: true)
        
    }

    // Give the confirmation and send user back to the home screen
    @IBAction func agreeTo() {
        // Create the action buttons for the alert.
        let defaultAction = UIAlertAction(title: "OK",
                                          style: .default) { action in
            
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Home") as! MainViewController
            nextViewController.modalPresentationStyle = .fullScreen
            //self.present(nextViewController, animated:true, completion:nil)
            self.navigationController!.pushViewController(nextViewController, animated: true)
            
        }
        
        
        // Create and configure the alert controller.
        let alert = UIAlertController(title: "Points added successfully!",
                                      message: "",
                                      preferredStyle: .alert)
        
        alert.addAction(defaultAction)
        
        self.present(alert, animated: true) {
            
        }
    }
    
    
}
