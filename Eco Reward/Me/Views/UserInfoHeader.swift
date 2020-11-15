//
//  UserInfoHeader.swift
//  Eco Reward
//
//  Created by Yang Xu on 16/10/20.
//

import UIKit
import Firebase



class UserInfoHeader: UIView {
    
    
    
    // MARK: - User Profile Picture
    let profileImageView: UIImageView = {
        
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        let docRef = db.collection("users").document(uid!)
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        docRef.getDocument { (document, error) in
            
            if let document = document, document.exists {
                
                let data = document.data()
                let email = data!["useremail"] as! String
                let safeEmail = StorageManager.emailFormatter(email: email)
                let filename = safeEmail + "_profile_picture.png"
                let path = "images/" + filename
                
                StorageManager.shared.downloadURL(for: path, completion: { result in
                    switch result {
                    case .success(let url):
                        let data = try? Data(contentsOf: url)
                        let image = UIImage(data: data!)
                        iv.image = image
                    case .failure(let error): print("Failed to get download url: \(error), load the default profile picture" )
                    }
                })
                
            }
            else {
                print("Fail to read database")
            }
        }
        return iv
    }()
    
    
    // MARK: - Name Label
    let usernameLabel: UILabel = {
        
        let label = UILabel()
        
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        let docRef = db.collection("users").document(uid!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                let data = document.data()
                let nickname = data!["nickname"] as! String
                label.text = nickname
            } else {
                print("Fail to read database")
                
            }
        }
        
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    // MARK: - Email Label
    let emailLabel: UILabel = {
        
        let label = UILabel()
        
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        let docRef = db.collection("users").document(uid!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                
                let data = document.data()
                let email = data!["useremail"] as! String
                label.text = email
            } else {
                print("Fail to read database")
                
            }
        }
        
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let profileImageDimension: CGFloat = 60
        
        
        
        addSubview(profileImageView)
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profileImageView.layer.cornerRadius = profileImageDimension / 2
        
        addSubview(usernameLabel)
        usernameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -10).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        
        addSubview(emailLabel)
        emailLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 10).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}




