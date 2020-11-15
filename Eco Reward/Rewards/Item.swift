//
//  Items.swift
//  Eco Reward
//
//  Created by Yang Xu on 23/10/20.
//
// This is the model for item


import Foundation
import UIKit
import Firebase
import FirebaseAuth

class Item {
    

    
    var id: String!
    var name: String!
    var description: String!
    var price: Double!
    
    var image: UIImage?
    var imageName: String?
    
    var imageLinks: [String]!
    
    init (_name: String, _imageName: String) {
        
        id = ""
        name = _name
        imageName = _imageName
        image = UIImage(named: _imageName)
        
    }
    
    init (_dictionary: NSDictionary) {
        
        id = _dictionary[kOBJECTID] as? String
        name = _dictionary[kNAME] as? String
        description = _dictionary[kDESCRIPTION] as? String
        price = _dictionary[kPRICE] as? Double
        image = UIImage(named: _dictionary[kIMAGENAME] as? String ?? "")
        imageLinks = _dictionary[kIMAGELINKS] as? [String]
    }
    
   
    
}

//MARK: Download item from firebase

func downloadItemFromFirebase(completion: @escaping (_ itemArray: [Item]) -> Void) {
    
    //findActivatedItem()
    
    var itemArray: [Item] = []
    
    FirebaseReference(.Items).getDocuments { (snapshot, error) in
        guard let snapshot = snapshot else {
            completion(itemArray)
            return
        }
        if !snapshot.isEmpty {
            for itemDict in snapshot.documents {


                
                itemArray.append(Item(_dictionary: itemDict.data() as NSDictionary))
                //print(itemDict.data())
                }

            }

        completion(itemArray)
        }
    }
    



func filterItemFromFirebase(completion: @escaping (_ itemArray: [Item]) -> Void) {
    

    var itemArray: [Item] = []

    FirebaseReference(.Items).getDocuments { (snapshot, error) in
        guard let snapshot = snapshot else {
            completion(itemArray)
            return
        }

        if !snapshot.isEmpty {
            for itemDict in snapshot.documents {
                
                
                itemArray.append(Item(_dictionary: itemDict.data() as NSDictionary))
               
            }
        }
        completion(itemArray)
    }

}

//MARK: - Find activated items

func findActivatedItem(completion: @escaping (_ documents:[String]) -> Void) {

    let db = Firestore.firestore()
    let uid = Auth.auth().currentUser?.uid
    var documentId: String!
    var documents: [String] = []
    
    db.collection("users").whereField("uid", isEqualTo: uid!).getDocuments { (snapshot, error) in
        if error != nil {
            print(error!)
        } else {
            for document in(snapshot?.documents)! {
                documentId = document.documentID
                //print(documentId!)

            }

        }

        db.collection("users").document(documentId!).collection("reward").getDocuments { (snapshot, error) in
            if error != nil {
                print(error!)
            } else {
                for document in(snapshot?.documents)! {
                    documents.append(document.documentID)

                }
                completion(documents)
            }
            
        }

    }

}





//MARK: - Save item function

func saveItemToFirebase(_ item: Item) {
    
    let id = UUID().uuidString
    item.id = id
    
    FirebaseReference(.Items).document(id).setData(itemDictionaryFrom(item) as! [String: Any])
        
    }


//MARK: Helpers

func itemDictionaryFrom(_ item: Item) -> NSDictionary {
    
    return NSDictionary(objects: [item.id, item.name, item.description, item.price, item.imageName, item.imageLinks], forKeys: [kOBJECTID as NSCopying, kNAME as NSCopying, kDESCRIPTION as NSCopying, kPRICE as NSCopying, kIMAGENAME as NSCopying, kIMAGELINKS as NSCopying])
    
}

// use only one time
// func createItemSet() {
//
//    let macroNaturalMixedNuts = Item(_name: "Macro Natural Mixed Nuts", _imageName: "macroNaturalMixedNuts")
//    let theCollectiveOrganicStrawberryYoghurt = Item(_name: "The Collective Organic Strawberry Yoghurt", _imageName: "theCollectiveOrganicStrawberryYoghurt")
//    let impressedColdPressedJuiceSummerGreens = Item(_name: "Impressed Cold Pressed Juice Summer Greens", _imageName: "impressedColdPressedJuiceSummerGreens")
//    let macroOrganicGreenBeans = Item(_name: "Macro Organic Green Beans", _imageName: "macroOrganicGreenBeans")
//    let realMeatVeganMeat = Item(_name: "REAL MEAT Vegan Meat", _imageName: "realMeatVeganMeat")
//    let bioBagCompostablePlasticBag = Item(_name: "Bio Bag Compostable Plastic Bag", _imageName: "bioBagCompostablePlasticBag")
//    let beNaturalCinnamonMiniBitesCereal = Item(_name: "Be Natural Cinnamon Mini Bites Cereal 460g", _imageName: "beNaturalCinnamonMiniBitesCereal")
//    let macroRedGrapesOrganic = Item(_name: "Macro Red Grapes Organic 500g", _imageName: "macroRedGrapesOrganic")
//    let arrayOfItems = [macroNaturalMixedNuts, theCollectiveOrganicStrawberryYoghurt, impressedColdPressedJuiceSummerGreens, macroOrganicGreenBeans, realMeatVeganMeat, bioBagCompostablePlasticBag, beNaturalCinnamonMiniBitesCereal, macroRedGrapesOrganic]
//
//    for item in arrayOfItems {
//        saveItemToFirebase(item)
//    }
//}
