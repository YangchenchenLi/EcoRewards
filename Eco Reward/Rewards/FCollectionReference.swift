//
//  FCollectionReference.swift
//  Eco Reward
//
//  Created by Yang Xu on 22/10/20.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String {
    case Items
}

func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    
    return Firestore.firestore().collection(collectionReference.rawValue)
    
}


