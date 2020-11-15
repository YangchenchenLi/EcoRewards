//
//  RecordViewModel.swift
//  Eco Reward
//
//  Created by Yang Xu on 19/10/20.
//


// NOT Finished side project

import Foundation
import FirebaseFirestore

class RecordViewModel: ObservableObject {
    
    @Published var records = [Record]()
    
    private var db = Firestore.firestore()
    
    func fetchDate() {
        db.collection("user").addSnapshotListener { (querySnapshot, error) in
            
        }
    }
}
