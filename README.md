## Application "Souvenirs de famille" (French)

## Sommaire

1. [L'Objectif](#lobjectif)
2. [Fonctionalité](#fonctionalité)
3. [Conclusion](#conclusion)

### L'Objectif

L'objectif de ce code est de créer une application client-serveur pour les familles de toutes sortes qui permet aux utilisateurs de créer des comptes, de se connecter et de partager des souvenirs de famille avec leurs proches. Elle permet à une famille d'interagir et de partager des souvenirs en transcendant les frontières, comme en voyageant, à travers un service en ligne, et répond aux besoins des utilisateurs qui veulent créer une application de souvenirs familiaux en éliminant les obstacles relatives à l'argent, à la santé et aux voyages dans l'état actuel du monde (par exemple, la guerre en Ukraine, les pandémies en cours, etc.).  L'application est développée en utilisant Swift et SwiftUI, ce qui la rend adaptée aux appareils iOS. Elle utilise Firebase, en particulier Firebase Authentication, Firebase Storage et Cloud Firestore, pour fournir des fonctionnalités d'authentification, de stockage et de récupération des données. Il demande à l'utilisateur, toute personne d'une famille, de saisir son adresse électronique et son mot de passe ou de créer un nouveau compte en utilisant une adresse électronique, un mot de passe et une photo différents, qui seront vérifiés et sauvegardés par Firebase Authentification. Un message expliquant s'il s'agit d'une erreur ou d'un succès s'affiche. Le code permet aux utilisateurs de créer des comptes, de se connecter avec des identifiants existants et de sauvegarder leurs informations personnelles ainsi que leurs souvenirs de famille préférés. 

<img width="178" alt="Screen Shot 2023-08-13 at 2 07 26 AM" src="https://github.com/WayneSzchenTFS/Family-Memories-Portal/assets/92103114/87ae404b-6423-4397-b14a-3e466900b7a4">

### Fonctionalité et Utilisation

Le code se compose de deux vues principales : LoginView et SaveDetailView. La vue LoginView sert de point d'entrée où les utilisateurs peuvent se connecter avec leurs identifiants ou créer un nouveau compte, sauvegardé sur Firebase Authentification et Storage pour l'image (à l'aide d'ImagePicker). Lorsque la connexion est réussie, le code passe à la fenêtre SaveDetailView, qui permet aux utilisateurs de saisir leurs informations personnelles et de les enregistrer dans le Cloud Firestore à l'aide du code SaveViewModel, qui crée ou enregistre les nouvelles données (avec le LoginSaveModel, un modèle qui représente les données de chaque utilisateur, notamment le nom, l'âge, le rôle au sein de la famille, etc.) Le fichier FirebaseManager est un simple fichier qui empêche le programme de se bloquer, en réinitialisant le code plusieurs fois. Le MainMessagesView a été conçu pour afficher tous les utilisateurs créés et leur statut en ligne, pour afficher leurs messages et pour permettre à toute la famille de voir leurs comptes. Cependant, il s'agit encore d'un travail en cours qui nécessite quelques mises à jour.

<img width="178" alt="Screen Shot 2023-08-13 at 2 07 46 AM" src="https://github.com/WayneSzchenTFS/Family-Memories-Portal/assets/92103114/080dadd2-fc7c-45a7-91ef-bc9dd4c6395b">


Firebase Authentication est utilisé pour gérer l'authentification des utilisateurs, ce qui permet à ces derniers de se connecter avec leur adresse électronique et leur mot de passe. Firebase génère un identifiant spécifique pour chaque image téléchargée dans Firebase Storage et pour chaque compte utilisateur créé avec une combinaison d'email et de mot de passe. Lorsqu'un utilisateur télécharge une image ou un compte pour son profil, les données sont stockées dans Firebase Storage et Firebase génère un identifiant unique pour cette image. Cet identifiant sert de nom de fichier ou d'identifiant pour l'image ou les comptes dans le système Firebase. Cet identifiant unique permet de récupérer et de gérer efficacement l'image dans Firebase Storage. L'ID utilisateur permet à Firebase de différencier les différents comptes utilisateurs et d'associer les données et autorisations correctes à chaque compte.

La fonction loginUser() utilise l'API Auth de Firebase pour authentifier l'utilisateur en vérifiant ses informations d'identification dans la base de données Firebase. Firebase Storage est utilisé pour stocker les images du profil de l'utilisateur. Lors de la création d'un nouveau compte, les utilisateurs peuvent sélectionner une image, qui est ensuite convertie au format JPEG et stockée dans Firebase Storage. La fonction persistImageToStorage() est chargée de télécharger l'image dans Firebase Storage et de récupérer l'URL de téléchargement de l'image stockée. Cloud Firestore est utilisé pour stocker et récupérer des données spécifiques à l'utilisateur. Dans la fenêtre SaveDetailView, les utilisateurs peuvent saisir leurs informations personnelles telles que leur nom, leur âge, leur lien de parenté et leur souvenir préféré. La fonction saveData() de la classe SaveViewModel est chargée d'enregistrer les données saisies dans Cloud Firestore et de les associer au compte de l'utilisateur.

<img width="388" alt="Screen Shot 2023-08-13 at 2 08 03 AM" src="https://github.com/WayneSzchenTFS/Family-Memories-Portal/assets/92103114/951ba991-3976-4d59-8ad0-8fda9014d9b9">

<img width="408" alt="Screen Shot 2023-08-13 at 2 08 36 AM" src="https://github.com/WayneSzchenTFS/Family-Memories-Portal/assets/92103114/2a6666a6-9123-49e8-af9c-9c40fc64f63f">

- La LoginView fournit un sélecteur segmenté permettant aux utilisateurs de choisir entre la connexion et la création d'un nouveau compte. Il permet également aux utilisateurs de sélectionner une image pour leur profil à l'aide du composant ImagePicker. 
- Les utilisateurs peuvent saisir leur adresse électronique et leur mot de passe dans les champs correspondants et, lorsqu'ils appuient sur le bouton "Se connecter", la fonction handleAction() est appelée. Si l'utilisateur choisit de créer un nouveau compte, la fonction createNewAccount() est appelée.
- Elle utilise l'authentification Firebase pour créer un nouveau compte utilisateur et, une fois la création réussie, elle appelle la fonction persistImageToStorage() pour télécharger l'image du profil dans Firebase Storage. 
- Lorsque l'utilisateur se connecte avec ses informations d'identification existantes, la fonction loginUser() est appelée. Elle authentifie l'utilisateur à l'aide de Firebase Authentication et affiche le message d'état de connexion en conséquence. Lorsque la connexion est réussie, le code navigue vers le MainMessagesView.
- Dans la fenêtre SaveDetailView, les utilisateurs peuvent saisir leurs informations personnelles, notamment leur nom, leur âge, leur lien de parenté et leur souvenir préféré. 
- Le bouton Annuler permet aux utilisateurs de quitter la vue sans enregistrer les données saisies. Le bouton Enregistrer invoque la fonction saveData(), qui enregistre les données saisies dans Cloud Firestore à l'aide du modèle SaveViewModel. Si les données sont sauvegardées avec succès, la vue est fermée.
  
<img width="210" alt="Screen Shot 2023-08-13 at 2 08 52 AM" src="https://github.com/WayneSzchenTFS/Family-Memories-Portal/assets/92103114/7b2b990a-8a51-4465-994c-fff21fd81fa2">


### Conclusion

En conclusion, le code présenté dans ce rapport fournit une application client-serveur pour créer une application de souvenirs de famille. Il intègre Firebase Authentication, Firebase Storage et Cloud Firestore pour gérer l'authentification des utilisateurs, le stockage des images et des données. Les utilisateurs peuvent créer des comptes, se connecter, entrer leurs informations personnelles et leurs souvenirs de famille préférés, et les sauvegarder en toute sécurité sur le cloud. Le code est conçu pour répondre aux besoins spécifiques des personnes cherchant à créer une application de souvenirs de famille et est implémenté en utilisant Swift et SwiftUI, offrant une compatibilité avec les appareils iOS.
