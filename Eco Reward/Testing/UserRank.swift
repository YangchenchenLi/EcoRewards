////
////  UserRank.swift
////  Eco Reward
////
////  Created by Yang Xu on 22/10/20.
////
//
//import Foundation
//import FirebaseFirestore
//import FirebaseAuth
//
//func getUserRank() {
//    
//    let db = Firestore.firestore()
//    let uid = Auth.auth().currentUser?.uid
//    
//    var rank = 0
//    
//    db.collection("users").order(by: "points", descending: true).addSnapshotListener { (querySnapshot, error) in
//        guard let documents = querySnapshot?.documents else {
//            print("NO documents")
//            return
//        }
//        
//        documents.map { (queryDocumentSnapshot) -> Leader in
//            
//            rank = rank + 1
//            let data = queryDocumentSnapshot.data()
//            
//            let id = data["uid"] as? String ?? ""
//            let nickname = data["nickname"] as? String ?? ""
//            let points = data["points"] as? Int ?? 0
//            
//            if uid == id {
//                return Leader(rank: rank, id: id, nickname: nickname, points: points)
//            }
//        }
//    }
//}
