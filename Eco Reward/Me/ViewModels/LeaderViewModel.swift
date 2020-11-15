//
//  LeaderViewModel.swift
//  Eco Reward
//
//  Created by Yang Xu on 18/10/20.
//

/* This file retrieves current points of the users from the database. */

import Foundation
import FirebaseFirestore


class LeaderViewModel: ObservableObject {
    
    @Published var leaders = [Leader]()
    
    private var db = Firestore.firestore()
    
    
    func fetchData() {
        
        
        var rank = 0
        // define how many users are shown in the leaderboard
        
        db.collection("users").order(by: "points", descending: true).limit(to: 20).addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("NO documents")
                return
            }
            print(documents)
            self.leaders = documents.map { (queryDocumentSnapshot) -> Leader in
                let data = queryDocumentSnapshot.data()
                
                rank = rank + 1
                
                let id = data["uid"] as? String ?? ""
                let nickname = data["nickname"] as? String ?? ""
                let points = data["points"] as? Int ?? 0
                
                
                return Leader(rank: rank, id: id, nickname: nickname, points: points)
            }
        }
    }
}

