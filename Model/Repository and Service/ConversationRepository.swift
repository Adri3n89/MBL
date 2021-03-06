//
//  ConversationRepository.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 30/11/2021.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

final class ConversationRepository: ConversationRepositoryProvider {
    
    private let auth = Auth.auth()
    var currentUserID: String? {
        get {
            return auth.currentUser?.uid
        }
    }
    private let ref = Database.database(url: Constantes.refURL).reference()
    
    
    func createConversation(user: String) -> String {
        let data = ["user1": user,
                    "user2": currentUserID]
        let newChild = ref.child("Conversations").childByAutoId()
        newChild.setValue(data)
        return newChild.key!
    }
    
    func searchIfConversationAlreadyExist(user: String, completed: @escaping (ConversationData) -> Void) {
        ref.child("Conversations").observeSingleEvent(of: .value, with: { conversations in
            for conversation in conversations.children.allObjects as! [DataSnapshot] {
                let value = conversation.value as? NSDictionary
                let user1 = value?["user1"] as! String
                let user2 = value?["user2"] as! String
                if (user1 == self.currentUserID && user2 == user) || (user1 == user && user2 == self.currentUserID)  {
                    self.fetchConversation(conversationID: conversation.key) { convers in
                        self.fetchUserConversationForMapView(id: convers.conversationID) { conversation in
                            completed(conversation!)
                        }
                    }
                    return
                }
            }
            self.fetchUserConversationForMapView(id: self.createConversation(user: user)) { conver in
                completed(conver!)
            }
         })
    }
    
    func addMessage(idConversation: String, text: String, date: String) {
        let data = ["date": date,
                    "text": text,
                    "userID": currentUserID]
        let newChild = ref.child("Conversations").child(idConversation).child("Messages").childByAutoId()
        newChild.setValue(data)
    }
    
    func fetchUserConversations(completed: @escaping (ConversationData?) -> Void) {
        ref.child("Conversations").observeSingleEvent(of: .value, with: { conversations in
            for conversation in conversations.children.allObjects as! [DataSnapshot] {
                let value = conversation.value as? NSDictionary
                let user1ID = value?["user1"] as! String
                let user2ID = value?["user2"] as! String
                var conversationData = self.fetchConversationData(conversation: conversation)
                var user1 : UserData? {
                    didSet {
                        if user1 != nil {
                            self.ref.child("Users").child(user2ID).observe(.value, with: { infos in
                                user2 = self.fetchData(data: infos)
                             })
                        }
                    }
                }
                var user2 : UserData? {
                    didSet {
                        if user2 != nil {
                            conversationData?.user2 = user2
                            if user1ID == self.currentUserID || user2ID == self.currentUserID {
                                completed(conversationData)
                            }
                        }
                    }
                }
                self.ref.child("Users").child(user1ID).observe(.value, with: { infos in
                    user1 = self.fetchData(data: infos)
                    conversationData?.user1 = user1
                 })
            }
         })
    }
    
    func fetchConversation(conversationID: String, completed: @escaping (ConversationData) -> Void) {
        ref.child("Conversations").child(conversationID).observe(.value, with: { conversation in
            completed(self.fetchConversationData(conversation: conversation)!)
            
         })
    }
    
    private func fetchConversationData(conversation: DataSnapshot) -> ConversationData? {
        let value = conversation.value as? NSDictionary
        guard let user1ID = value?["user1"] as? String,
              let user2ID = value?["user2"] as? String else {
            return nil
        }
       
        let messages = value?["Messages"] as! NSDictionary?
        var conversationData = ConversationData(conversationID: conversation.key, user1ID: user1ID, user2ID: user2ID, messages: [])
        if messages != nil {
            for message in messages! {
                let value = message.value as? NSDictionary
                let text = value?["text"] as! String
                let date = value?["date"] as! String
                let userID = value?["userID"] as! String
                conversationData.messages?.append(Message(text: text, date: date, userID: userID))
            }
        }
        return conversationData
    }
    
    private func fetchData(data: DataSnapshot) -> UserData {
        let value = data.value as? NSDictionary
        let name = value?["Name"] as! String
        let lastName = value?["LastName"] as! String
        let city = value?["City"] as! String
        let userID = value?["Userid"] as! String
        let picture = value?["Picture"] as! String?
        let refPic = value?["RefPic"] as! String?
        return UserData(name: name, lastName: lastName,userID: userID, city: city, picture: picture ?? Constantes.defaultProfilPicture, refPic: refPic ?? "")
    }
    
    func fetchUserConversationForMapView(id: String, completed: @escaping (ConversationData?) -> Void) {
        ref.child("Conversations").child(id).observeSingleEvent(of: .value, with: { conversation in
                let value = conversation.value as? NSDictionary
                let user1ID = value?["user1"] as! String
                let user2ID = value?["user2"] as! String
                var conversationData = self.fetchConversationData(conversation: conversation)
                var user1 : UserData? {
                    didSet {
                        if user1 != nil {
                            self.ref.child("Users").child(user2ID).observe(.value, with: { infos in
                                user2 = self.fetchData(data: infos)
                             })
                        }
                    }
                }
                var user2 : UserData? {
                    didSet {
                        if user2 != nil {
                            conversationData?.user2 = user2
                            if user1ID == self.currentUserID || user2ID == self.currentUserID {
                                completed(conversationData)
                            }
                        }
                    }
                }
                self.ref.child("Users").child(user1ID).observe(.value, with: { infos in
                    user1 = self.fetchData(data: infos)
                    conversationData?.user1 = user1
                 })
            
         })
    }
    
    
}
