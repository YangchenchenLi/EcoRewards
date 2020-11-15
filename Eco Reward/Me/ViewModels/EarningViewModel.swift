//
//  EarningViewModel.swift
//  Eco Reward
//
//  Created by Yang Xu on 29/10/20.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class EarningViewModel: ObservableObject {
    
    @Published var record = [Record]()
    
    private var db = Firestore.firestore()
    let uid = Auth.auth().currentUser?.uid
    
    func fetchData() {
   

        db.collection("users").document(uid!).collection("purchase").order(by: "order", descending: false).addSnapshotListener { (querySnapshot, error) in
            
            guard let documents = querySnapshot?.documents else {
                print("NO documents")
                return
            }

            self.record = documents.map {(queryDocumentSnapshot) -> Record in
                
                let data = queryDocumentSnapshot.data()

                let id = data["id"] as? String ?? ""
                let date = data["date"] as? String ?? ""
                let numofItems = data["numOfItems"] as? Double ?? 0
                let totalPoints = data["totalPoints"] as? Double ?? 0
                let bonus = data["bonus"] as? Double ?? 0
                let avgstars = (totalPoints/numofItems)
                let order = data["order"] as? Int ?? 0
    
                
                
                
                return Record(id: id, date: date, order: order, points: totalPoints, avgstars: avgstars, bonus: bonus)
                
            }
        }
    }
}
