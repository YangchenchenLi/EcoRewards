//
//  ViewController.swift
//  Eco Reward
//
//  Created by Yang Xu on 14/10/20.
//

import UIKit
import Firebase
import FirebaseAuth

class MainViewController: UIViewController {
    
    //MARK: - Connect user interface component to a property in a view controller
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var monthPoints: UILabel!
    @IBOutlet weak var monthAvgStars: UILabel!
    
    // This is outlet is cancelled temporarily
    @IBAction func goToRedeemButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let redeemVC = storyboard.instantiateViewController(identifier: "RewardController") as! RewardViewController
        self.navigationController?.pushViewController(redeemVC, animated: true)
    }
    
    
    @IBAction func goToCamButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let camVC = storyboard.instantiateViewController(identifier: "Cam") as! QRScannerController
        self.navigationController?.pushViewController(camVC, animated: true)
    }
    
    
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 83/255, green: 181/255, blue: 96/255, alpha: 1)
        self.navigationItem.hidesBackButton = true
        
        if FirebaseAuth.Auth.auth().currentUser == nil {
            validateAuth()} else {
                setUpElements()
            }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // check if user is login in or not
        //let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        validateAuth()
        setUpElements()
    }
    
    
    //MARK: - Check if user is already logged in
    private func validateAuth() {
        //if user is not logged in, pop up the login screen
        if  FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
    
    // MARK: - Set up the elements displayed on screen
    private func setUpElements() {
        
        // hide the placeholder text of all labels
        self.firstName.alpha = 0
        self.points.alpha = 0
        self.monthPoints.alpha = 0
        self.monthAvgStars.alpha = 0
        
        // connect to the database
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        
        
        
        // read data in the document of current user
        db.collection("users").whereField("uid", isEqualTo: uid!).getDocuments { [self] (snapshot, error) in
            
            if error != nil {
                print(error!)
            } else {
                for document in (snapshot?.documents)! {
                    
                    // get the names and points
                    let documentData = document.data()
                    
                    //print(documentData)
                    let fname = documentData["firstname"] as? String
                    let currentPoint = documentData["points"] as? Int
                    let pointString = String(currentPoint!)
                    let uid = documentData["uid"] as? String
                    
                    // assign name and points to the UI label
                    self.firstName.text = fname
                    self.points.text = pointString
                    
                    
                    //get the record sub-collection in current user's document
                    let userCollection = db.collection("users").document(uid!)
                    
                    let currentMonth = Int(getCurrentMonth())
                    
                    userCollection.collection("purchase").whereField("month", isEqualTo: currentMonth!).getDocuments { (subSnapshot, err) in
                        
                    
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            
                            var totalPointsArray: Array<Double> = []
                            var avgStarsArray: Array<Double> = []
                            
                            for subDocument in subSnapshot!.documents {
                                
       
                                let totalPoints = subDocument["totalPoints"] as! Double
                                totalPointsArray.append(totalPoints)
                                
                                let numOfItems = subDocument["numOfItems"] as! Double
                                let avgStars = totalPoints/numOfItems
                                avgStarsArray.append(avgStars)
                            }

                            
                            let rawCurrentMonthAvgStars = avgStarsArray.average  //Double
                            let currentMonthTotalPoints = String(totalPointsArray.reduce(0, +))
                            let formattedCurrentMonthAvgStars = String(format:"%.2f", rawCurrentMonthAvgStars)
                            
                            self.monthPoints.text = formattedCurrentMonthAvgStars
                            self.monthAvgStars.text = currentMonthTotalPoints

                        }
                    }
                    // make all data labels re-appear
                    self.firstName.alpha = 1
                    self.points.alpha = 1
                    self.monthPoints.alpha = 1
                    self.monthAvgStars.alpha = 1
                }
            }
            
        }
    }
}

// MARK: - Calculate average of an Array
extension Array where Element: BinaryInteger {

    /// The average value of all the items in the array
    var average: Double {
        if self.isEmpty {
            return 0.0
        } else {
            let sum = self.reduce(0, +)
            return Double(sum) / Double(self.count)
        }
    }

}

extension Array where Element: BinaryFloatingPoint {

    /// The average value of all the items in the array
    var average: Double {
        if self.isEmpty {
            return 0.0
        } else {
            let sum = self.reduce(0, +)
            return Double(sum) / Double(self.count)
        }
    }

}
