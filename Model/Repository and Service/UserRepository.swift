//
//  UserRepository.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 15/12/2021.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

final class UserRepository: ObservableObject {
    
    static let shared = UserRepository()
    private let ref = Database.database(url: Constantes.refURL).reference()
    var userID: String? {
        get {
            return Auth.auth().currentUser?.uid
        }
    }

    func createUserInfo(email: String, name: String, lastName: String, city: String) {
        let data = ["Email": email as String,
                    "Name": name as String,
                    "LastName": lastName as String,
                    "Userid": Auth.auth().currentUser!.uid as String,
                    "City": city as String]
        let newChild = ref.child("Users").child(Auth.auth().currentUser!.uid)
        newChild.setValue(data)
    }
    
    func updateProfil(key: String, value: String) {
        guard let user = Auth.auth().currentUser else {
            return
        }
        let newChild = ref.child("Users").child(user.uid).child(key)
        newChild.setValue(value)
    }
    
    func addOrRemove(id: String, type: String) {
        // ajoute l'id d'un jeu dans la library de l'utilisateur et si le jeu y est déja il le retire
        ref.child("Users").child(userID!).child(Constantes.gameType[0]).observeSingleEvent(of: .value, with: { games in
            for game in games.children.allObjects as! [DataSnapshot] {
                let value = game.value as? NSDictionary
                let gameId = value?["ID"] as! String
                if id == gameId {
                    self.ref.child("Users").child(self.userID!).child(type).child(game.key).removeValue()
                    return
                }
            }
            self.ref.child("Users").child(self.userID!).child(type).childByAutoId().child("ID").setValue(id)
         })
    }
    
    func fetchUserGame(type: String, user: String, completed: @escaping ([String]) -> Void) {
        ref.child("Users").child(user).child(type).observe(.value, with: { games in
            var gameID: [String] = []
            for game in games.children.allObjects as! [DataSnapshot] {
                let value = game.value as? NSDictionary
                let id = value?["ID"] as! String
                gameID.append(id)
                if games.children.allObjects.count == gameID.count {
                    completed(gameID)
                }
            }
         })
    }
    
    func fetchUserInfo(user: String,completed: @escaping (UserData) -> Void) {
        ref.child("Users").child(user).observe(.value, with: { info in
            let value = info.value as? NSDictionary
            let name = value?["Name"] as! String
            let lastName = value?["LastName"] as! String
            let city = value?["City"] as! String
            let userID = value?["Userid"] as! String
            let picture = value?["Picture"] as! String?
            let refPic = value?["RefPic"] as! String?
            completed(UserData(name: name, lastName: lastName,userID: userID, city: city, picture: picture ?? Constantes.defaultProfilPicture, refPic: refPic ?? ""))
        })
    }
    
    func fetchAllUsers(completed: @escaping ([UserData]) -> Void) {
        var usersInfo: [UserData] = []
        ref.child("Users").observe(.value) { users in
            for user in users.children.allObjects as! [DataSnapshot] {
                let value = user.value as? NSDictionary
                let name = value?["Name"] as! String
                let lastName = value?["LastName"] as! String
                let city = value?["City"] as! String
                let userID = value?["Userid"] as! String
                let picture = value?["Picture"] as! String?
                let refPic = value?["RefPic"] as! String?
                usersInfo.append(UserData(name: name, lastName: lastName, userID: userID, city: city, picture: picture ?? Constantes.defaultProfilPicture, refPic: refPic ?? ""))
                if users.children.allObjects.count == usersInfo.count {
                    completed(usersInfo)
                }
            }
        }
    }
    
    
}
