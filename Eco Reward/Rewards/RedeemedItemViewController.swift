//
//  RedeemedItemViewController.swift
//  Eco Reward
//
//  Created by Yang Xu on 29/10/20.
//

import UIKit
import Firebase


class RedeemedItemViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var codeLabel: UILabel!
    
    //MARK: - Vars
    var item: Item!
    var itemImages: [UIImage] = []
    
    //MARK: - ViewLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }
    
    private func setupUI() {
        
        if item != nil {
            
            self.title = item.name
            
            let itemId = item.id
            
            nameLabel.text = item.name
            imageView.image = item.image
            
            descriptionTextView.text = item.description

            let db = Firestore.firestore()
            let uid = Auth.auth().currentUser?.uid

            let docRef = db.collection("users").document(uid!).collection("reward").document(itemId!)

            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    let code = data!["code"] as? String
                    
                    self.codeLabel.text = code
                } else {
                    print("Document does not exist")
                }
            }
        }
        
    }
    
}



//MARK: - Fetch redeemed item code
extension RedeemedItemViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell()
        
    }
    
}
