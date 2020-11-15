//
//  ItemViewController.swift
//  Eco Reward
//
//  Created by Yang Xu on 24/10/20.
//

import UIKit
import Firebase


class ItemViewController: UIViewController {
    
    //MARK: -IBoutlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var priceLabel: UILabel!
    

    
    @IBAction func redeemButton(_ sender: Any) {
        
        checkUserPoints { (result) in
            if result == true {
                let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
                
                actionSheet.addAction(UIAlertAction(title: "Confirm",
                                                    style: .destructive,
                                                    handler: { action in
                                                        self.redeemAction()
                                                        self.agreeTo()

                                                    }))
                
                actionSheet.addAction(UIAlertAction(title: "Cancel",
                                                    style: .cancel,
                                                    handler: nil))
                
                self.present(actionSheet, animated: true)

                
            }
            else {
                let actionSheet = UIAlertController(title: "", message: "Not enough points", preferredStyle: .actionSheet)
                
                actionSheet.addAction(UIAlertAction(title: "Cancel",
                                                    style: .cancel,
                                                    handler: nil))
                
                self.present(actionSheet, animated: true)
                
            }
            
        }
  
    }
    
    //MARK: - Vars
    var item: Item!
    var itemImages: [UIImage] = []

    
    
    
    
    //MARK: - ViewLifecycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
   
    }
    
    
    
    //MARK: - Download Pictures
    
    private func downloadPictures() {
        
        
    }
    
    //MARK: - Setup UI
    
    private func setupUI() {
        
        if item != nil {
            self.title = item.name
            nameLabel.text = item.name
            priceLabel.text = String(item.price)
            imageView.image = item.image
            
            descriptionTextView.text = item.description
            
        }
        
    }
    
    //MARK: - Button Click Action
    func redeemAction() {
        let db = Firestore.firestore()
        let uid = Firebase.Auth.auth().currentUser?.uid
        
        
        let code = self.codeGenerator()
        
        db.collection("users").document(uid!).collection("reward").document((item.id)!).setData(["id": item.id!,
                                                                                                 "code": code])
        {err in
            if let err = err {
                print("Error redeeming item: \(err)")
            } else {
                print("Item redeemed")
            }
        }
        
        updatePoints(points: -(item.price))
        
    }
    
    
    
    func codeGenerator() -> String {
        
        let letters : NSString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)

        var randomString = ""

        for _ in 0 ..< 4 {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }

        return randomString
    }
    
    
    
    func checkUserPoints(completion: @escaping (Bool) -> Void) {
        
        let db = Firestore.firestore()
        let uid = Firebase.Auth.auth().currentUser?.uid
        
        let docRef = db.collection("users").document(uid!)
        
        
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let points = data!["points"] as? Int
                completion(Double(points!) >= self.item.price)
            } else {
                print("Document does not exist")
            }
        }
    }
    

    //    @objc private func didTap() {
    //
    //        let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
    //
    //        actionSheet.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler: { [weak self]_ in
    //
    //            guard let strongSelf = self else{
    //                return
    //            }
    //
    //            do {
    //                let db = Firestore.firestore()
    //                let uid = Firebase.Auth.auth().currentUser?.uid
    //                tr db.collection("users").document(uid!).collection("reward").document((self?.item.id)!).setData(["code": self?.item.id])
    //                {err in
    //                    if let err = err {
    //                        print("Error redeeming item: \(err)")
    //                    } else {
    //                        print("Item redeemed")
    //                    }
    //                }
    //
    //            }
    //            catch {
    //                print("Fail to redeem")
    //            }
    //
    //
    //
    //
    //        }))
    //    }
    @IBAction func agreeTo() {
        // Create the action buttons for the alert.
        let defaultAction = UIAlertAction(title: "OK",
                                          style: .default) { action in
            
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RewardController") as! RewardViewController
            nextViewController.modalPresentationStyle = .fullScreen
            //self.present(nextViewController, animated:true, completion:nil)
            self.navigationController!.pushViewController(nextViewController, animated: true)
            
        }
        
        
        // Create and configure the alert controller.
        let alert = UIAlertController(title: "Product redeemed successfully!",
                                      message: "",
                                      preferredStyle: .alert)
        
        alert.addAction(defaultAction)
        
        self.present(alert, animated: true) {
            
        }
    }
    
    
}

extension ItemViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell()
        
    }
    
}
