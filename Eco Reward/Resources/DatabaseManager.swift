//
//  DatabaseManager.swift
//  Eco Reward
//
//  Created by Yang Xu on 15/10/20.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Charts




public func readUserInfo(completion: @escaping (Array<Double>) -> Void) {
    let db = Firestore.firestore()
    let uid = Auth.auth().currentUser?.uid
    
    var recordArray: Array<Double> = []
    
    // Properties
    db.collection("users").document(uid!).collection("purchase").order(by: "order", descending: true).limit(to: 30).getDocuments { (querySnapshot, error) in
        
        if let error = error {
            print("Error getting documents: \(error)")
            return
        } else {
            
            for document in (querySnapshot?.documents)! {
                
                let data = document.data()
                //print(data)
                
                let numofItems = data["numOfItems"] as? Double ?? 0
                //print(numofItems)
                let totalPoints = data["totalPoints"] as? Double ?? 0
                //print(totalPoints)
                let avgstars = (totalPoints/numofItems)
                
                recordArray.append(avgstars)
                //print(recordArray)
                
            }
            
        }
        
        completion(recordArray)
    }
}


//func getYValues() -> Array<ChartDataEntry> {
//
//
//
//
//    readUserInfo { (recordArray) in
//
//        var array: Array<Double> = recordArray
//
//        //print(recordArray)
//
//        let count = recordArray.count
//
//        let number = 30 - count
//
//        for _ in 1...number {
//            array.append(0)
//
//        }
//
//        for i in 1...30 {
//            yValuesArray.append(ChartDataEntry(x: Double(i), y: Double(array[i-1])))
//        }
//        print(yValuesArray)
//
//    }
//
// return []
//}
