//
//  SaveViewModel.swift
//  Login
//
//  Created by Wayne Chen on 2023-06-02.
//

import Foundation
import FirebaseFirestore

class SaveViewModel: ObservableObject {
    @Published var spot = LoginSaveModel()
    
    func saveData(spot: LoginSaveModel) async -> Bool {
        let db = Firestore.firestore()
        
        if let id = spot.id {
            do {
                try await db.collection("users").document(id).setData(spot.dictionary)
                print("Data updated successfully")
                return true
            } catch {
                print("Could not update data in 'spots' \(error.localizedDescription)")
                return false
            }
        } else {
            do {
                try await db.collection("users").addDocument(data: spot.dictionary)
                print("Data created successfully")
                return true
            } catch {
                print("Could not create a new data in 'spots' \(error.localizedDescription)")
                return false
                
            }
        }
        
    }
}
