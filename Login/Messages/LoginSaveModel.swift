//
//  LoginSaveModel.swift
//  Login
//
//  Created by Wayne Chen on 2023-06-02.
//

import Foundation
import FirebaseFirestoreSwift

struct LoginSaveModel: Identifiable, Codable {
    @DocumentID var id: String?
    var name = ""
    var age = ""
    var rôle_famille = ""
    var souvenir = ""
    
    
    //Créer un modèle pour Cloud Firebase des types d'informations qui va être sauvegardér
    
    var dictionary : [String: Any] {
        return ["name": name, "age": age, "Rôle dans la famille": rôle_famille, "Souvenirs préférés": souvenir]
        
    }
}

