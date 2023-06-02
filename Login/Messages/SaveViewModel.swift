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
        
        // Vérifie si le modèle 'spot' a déjà un identifiant attribué
        if let id = spot.id {
            do {
                // Tente de mettre à jour les données dans la collection "users" avec l'identifiant correspondant
                try await db.collection("users").document(id).setData(spot.dictionary)
                print("Données mises à jour avec succès")
                return true
            } catch {
                print("Impossible de mettre à jour les données dans 'spots' \(error.localizedDescription)")
                return false
            }
        } else {
            do {
                // Tente de créer de nouvelles données dans la collection "users"
                try await db.collection("users").addDocument(data: spot.dictionary)
                print("Données créées avec succès")
                return true
            } catch {
                print("Impossible de créer de nouvelles données dans 'spots' \(error.localizedDescription)")
                return false
            }
        }
    }
}
