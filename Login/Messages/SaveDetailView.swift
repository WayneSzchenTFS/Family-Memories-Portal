//
//  SaveDetailView.swift
//  Login
//
//  Created by Wayne Chen on 2023-06-02.
//

import SwiftUI

struct SaveDetailView: View {

    @EnvironmentObject var spotVM: SaveViewModel
    @State var spot: LoginSaveModel
    @State var email = ""
    @State var password = ""
    @State var name = "" // Nouveau champ de texte pour le nom
    @State var age = "" // Nouveau champ de texte pour l'âge
    @State var familyRelationship = "" // Nouveau champ de texte pour la relation familiale
    @State var favoriteMemory = "" // Nouveau champ de texte pour le souvenir familial préféré
    
    
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        VStack{
            Group {
                // Champ de texte pour le nom
                TextField("Nom entier", text: $name)
                    .autocapitalization(.words)
                    .font(.title)
                // Champ de texte pour l'âge
                TextField("Age", text: $age)
                    .keyboardType(.numberPad)
                    .font(.title2)
                // Champ de texte pour la relation familiale
                TextField("votre rôle dans la famille", text: $familyRelationship)
                // Champ de texte pour le souvenir familial préféré
                TextField("Souvenirs de famille préférés", text: $favoriteMemory)
            }
            .textFieldStyle(.roundedBorder)
            .background(Color.white)
            .overlay{
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.5), lineWidth: 2)
            }
            .padding(.horizontal)
            
            Spacer()
            
            HStack {
                Button("Annuler") {
                    dismiss()
                }
                .padding()
                
                Spacer()
                
                Button("Sauvegarde") {
                    Task {
                        let success = await spotVM.saveData(spot: spot)
                        if success {
                            dismiss()
                        } else {
                            print("Error saving spot")
                        }
                    }
                    // Perform save operation
                    // You can add your logic here
                    dismiss()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8.0)
            }
            .padding(.horizontal)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        }
        /*
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(spot.id == nil)
        .toolbar {
            if spot.id == nil {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        Task {
                            let success = await spotVM.saveData(spot: spot)
                            if success {
                                dismiss()
                            } else {
                                print("Error saving spot")
                            }
                        }
                        dismiss()
                    }
                }
            }
        } */
        
    }

struct SaveDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SaveDetailView(spot: LoginSaveModel())
            .environmentObject(SaveViewModel())
    }
}
