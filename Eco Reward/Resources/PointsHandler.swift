//
//  PointsHandler.swift
//  Eco Reward
//
//  Created by Yang Xu on 27/10/20.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth




// function to update points to the user account
func updatePoints(points: Double) {
    
    let db = Firestore.firestore()
    let uid = FirebaseAuth.Auth.auth().currentUser?.uid
    
    let docRef = db.collection("users").document(uid!)


    docRef.getDocument { (document, error) in
        if let document = document, document.exists {
            let data = document.data()
            let currentPoints = data!["points"] as? Double
            docRef.updateData(["points" : points + currentPoints!])
            { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        } else {
            print("Failed updating points")
        }
        
    }
    
}


func computeBonusPoints(record: Array<String>) -> Int {
    
    let numOfItemsString = record[1]
    let totalPointsString = record[2]
    let spendingString = record[3]
    
    let numOfItems = Double(numOfItemsString)
    let totalPoints = Double(totalPointsString)
    let spending = Double(spendingString)
    
    let avgstars = (totalPoints!/numOfItems!)
    
    let levelOneBonus = levelOneMissionCheck(spending: spending!, avgstars: avgstars)
    let levelTwoBonus = levelTwoMissionCheck(spending: spending!, avgstars: avgstars)
    let levelThreeBonus = levelThreeMissionCheck(spending: spending!, avgstars: avgstars)
    
    let bonus = Int(max(levelOneBonus, levelTwoBonus, levelThreeBonus))
    
    //print(bonus)
    return bonus
    
}

// Check for bonus points by the level three rules
func levelThreeMissionCheck(spending: Double, avgstars: Double) -> Int {
    if spending >= 50 && avgstars >= 5 {
        return 200
    }
    else if  spending >= 50 && avgstars >= 4.7 {
        return 150
    }
    else if spending >= 50 && avgstars >= 4.5 {
        return 120
    }
    else if spending >= 25 && avgstars >= 5 {
        return 110
    }
    else if spending >= 30 && avgstars >= 4.7 {
        return 100
    }
    else if spending >= 30 && avgstars >= 4.5 {
        return 90
    }
    else {return 0}

}

// Check for bonus points by the level two rule
func levelTwoMissionCheck(spending: Double, avgstars: Double) -> Int {
    if spending >= 50 && avgstars >= 4 {
        return 60
    }
    else if  spending >= 50 && avgstars >= 3.5 {
        return 55
    }
    else if spending >= 50 && avgstars >= 3 {
        return 50
    }
    else if spending >= 30 && avgstars >= 4 {
        return 40
    }
    else if spending >= 30 && avgstars >= 3.5 {
        return 35
    }
    else if spending >= 30 && avgstars >= 3 {
        return 30
    }
    else {return 0}

}

// Check for bonus points by the level one rule
func levelOneMissionCheck(spending: Double, avgstars: Double) -> Int {
    if spending >= 20 && avgstars >= 4.5 {
        return 30
    }
    else if  spending >= 20 && avgstars >= 4 {
        return 25
    }
    else if spending >= 15 && avgstars >= 4.5 {
        return 25
    }
    else if spending >= 15 && avgstars >= 4 {
        return 20
    }
    else if spending >= 10 && avgstars >= 4.5 {
        return 15
    }
    else if spending >= 10 && avgstars >= 4 {
        return 10
    }
    else {return 0}

}


public func getCurrentMonth() -> String {
    let date = Date()
    let format = DateFormatter()
    format.dateFormat = "MM"
    let month = format.string(from:date)
    return month
}


