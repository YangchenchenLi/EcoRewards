//
//  QRCodeInfoHandler.swift
//  Eco Reward
//
//  Created by Yang Xu on 27/10/20.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

// date, number of items, total green credit points, total spending
// let dumbRecord: Array = ["21/09/2020","5","10", "20"]



// function to add new purchase record to the user account
func addNewRecord(record: Array<String>) {
    
    let dateString = record[0]
    let numOfItemsString = record[1]
    let totalPointsString = record[2]
    let spendingString = record[3]
    
    let numOfItems = Double(numOfItemsString)
    let totalPoints = Double(totalPointsString)
    let spending = Double(spendingString)
    let bonus = Double(computeBonusPoints(record: record))
    
    let dateInfo = dateString.split(separator: "/")
    let year = dateInfo[2]
    let month = dateInfo[1]
    let day = dateInfo[0]
    
    let dayInt = Int(day)
    let monthInt = Int(month)
    let yearInt = Int(year)
    
    let orderInt = (yearInt!*1000 + monthInt!*100 + dayInt!)
    
    //let collectionId = String(year + month)
    
    let db = Firestore.firestore()
    let uid = (FirebaseAuth.Auth.auth().currentUser?.uid)!
    let newDocumentId = UUID().uuidString
    
    
    let docData: [String: Any] = [
        "id": newDocumentId,
        "day": dayInt!,
        "month": monthInt!,
        "year": yearInt!,
        "date": dateString,
        "numOfItems": numOfItems!,
        "totalPoints": totalPoints!,
        "spending": spending!,
        "order": orderInt,
        "bonus": bonus
    ]
    
    db.collection("users").document(uid).collection("purchase").document(newDocumentId).setData(docData) { err in
        if let err = err {
            print("Error adding document: \(err)")
        } else {
            print("Document successfully written!")
        }
    }
}

