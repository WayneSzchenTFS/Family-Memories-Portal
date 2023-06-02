//
//  MainMessagesView.swift
//  Login
//
//  Created by Wayne Chen on 2023-06-01.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseFirestore


struct ChatUser {
    let uid, email, profileImageUrl: String
}
class MainMessagesViewModel: ObservableObject {
    
    @Published var errorMessage = ""  // Variable pour stocker les messages d'erreur
    @Published var chatUser: ChatUser?  // Variable pour stocker l'utilisateur de chat actuel

    init() {
        fetchCurrentUser()  // Récupère l'utilisateur de chat actuel au moment de l'initialisation
    }

    private func fetchCurrentUser() {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {
            self.errorMessage = "Impossible de trouver l'identifiant Firebase"  // Vérifie si l'identifiant Firebase de l'utilisateur est disponible, sinon affiche un message d'erreur
            return
        }
        
        FirebaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                self.errorMessage = "Erreur de recherche de l'utilisateur actuel: \(error)"  // Vérifie s'il y a une erreur lors de la recherche de l'utilisateur actuel dans Firestore, sinon affiche un message d'erreur
                print("Erreur de recherche de l'utilisateur actuel:", error)
                return
            }
            
            guard let data = snapshot?.data() else {
                self.errorMessage = "Aucune donnée n'a été trouvée"  // Vérifie si des données ont été trouvées pour l'utilisateur actuel dans Firestore, sinon affiche un message d'erreur
                return
            }
            
            let uid = data["uid"] as? String ?? ""  // Récupère l'identifiant de l'utilisateur
            let email = data["email"] as? String ?? ""  // Récupère l'email de l'utilisateur
            let profileImageUrl = data["profileImageUrl"] as? String ?? ""  // Récupère l'URL de l'image de profil de l'utilisateur
            self.chatUser = ChatUser(uid: uid, email: email, profileImageUrl: profileImageUrl)  // Crée un objet ChatUser avec les informations récupérées et l'assigne à la variable chatUser
        
            
        }
    }
    
}
struct MainMessagesView: View {
    
    @State var shouldShowLogOutOptions = false  // Variable d'état pour afficher ou masquer les options de déconnexion

    @ObservedObject private var vm = MainMessagesViewModel()  // Vue modèle observé pour gérer les données et les mises à jour

    var body: some View {
        NavigationView {
            
            VStack {
                
                customNavBar  // Affiche la barre de navigation personnalisée
                messagesView  // Affiche les messages
            }
            .overlay(
                newMessageButton, alignment: .bottom)  // Ajoute le bouton pour créer un nouveau message en bas de l'écran
            .navigationBarHidden(true)
        }
    }
    
    //représente la vue de la barre de navigation personnalisée dans MainMessagesView. Elle définit l'apparence et le comportement de la barre de navigation en haut de l'écran.
    private var customNavBar: some View {
        HStack(spacing: 16) {
            
            WebImage(url: URL(string: vm.chatUser?.profileImageUrl ?? "")) //affichage de l'image du profil de l'utilisateur dans la barre de navigation personnalisée, configure la vue WebImage pour charger et afficher l'image du profil de l'utilisateur en utilisant l'URL stockée dans vm.chatUser ?.profileImageUrl
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipped()
                .cornerRadius(50)
                .overlay(RoundedRectangle(cornerRadius: 44)
                            .stroke(Color(.label), lineWidth: 1)
                )
                .shadow(radius: 5)
            
            
            VStack(alignment: .leading, spacing: 4) {
                let email = vm.chatUser?.email.replacingOccurrences(of: "@gmail.com", with: "") ?? "" // Récupère l'email de l'utilisateur et le formate pour l'affichage avec @gmail.com
                Text(email)
                    .font(.system(size: 24, weight: .bold))
                
                HStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 14, height: 14)
                    Text("en ligne")
                        .font(.system(size: 12))
                        .foregroundColor(Color(.lightGray))
                }
                
            }
            
            Spacer()
            Button {
                shouldShowLogOutOptions.toggle()
            } label: {
                Image(systemName: "gear")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(.label))
            }
        }
        .padding()
        .actionSheet(isPresented: $shouldShowLogOutOptions) {
                .init(title: Text("Paramètres"), message: Text("Que voulez-vous faire ?"), buttons: [
                    .destructive(Text("Se déconnecter"), action: {
                        print("Se déconnecter")  // Affiche un message lors de la déconnexion de l'utilisateur
                    }),
                    .cancel()
                ])
            }
        }
    //génère une vue avec une liste défilante de messages, chacun représenté par une cellule de message contenant des informations sur l'utilisateur et le contenu du message.
    private var messagesView: some View {
        ScrollView {
            ForEach(0..<10, id: \.self) { num in
                VStack {
                    HStack(spacing: 16) {
                        Image(systemName: "person.fill")
                            .font(.system(size: 32))
                            .padding(8)
                            .overlay(RoundedRectangle(cornerRadius: 44)
                                        .stroke(Color(.label), lineWidth: 1)
                            )
                        
                        
                        VStack(alignment: .leading) {
                            Text("Nom d'utilisateur")
                                .font(.system(size: 16, weight: .bold))
                            Text("Message envoyé à l'utilisateur")
                                .font(.system(size: 14))
                                .foregroundColor(Color(.lightGray))
                        }
                        Spacer()
                        
                        Text("22d")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    Divider()
                        .padding(.vertical, 8)
                }.padding(.horizontal)
                
            }.padding(.bottom, 50)
        }
    }
    //responsable de la création d'un nouveau message. Le bouton a une fermeture {} comme action, ce qui signifie qu'il n'a actuellement aucune fonctionnalité spécifique lorsqu'il est actionné.
    private var newMessageButton: some View {
        Button {
            
        } label: {
            HStack {
                Spacer()
                Text("+ Nouveau Message")
                    .font(.system(size: 16, weight: .bold))
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.vertical)
                .background(Color.blue)
                .cornerRadius(32)
                .padding(.horizontal)
                .shadow(radius: 15)
        }
    }
}

struct Previews_MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
    }
}
