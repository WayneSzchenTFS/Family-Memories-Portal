//
//  FirebaseManager.swift
//  Login
//
//  Created by Wayne Chen on 2023-06-01.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore

class FirebaseManager: NSObject { //Pour éviter le plantage de l'utilisateur FirebaseManager et ne pas le réinitialiser plusieurs fois
    
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        FirebaseApp.configure()
        
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        
        super.init()
    }
    
}
