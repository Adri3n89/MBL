//
//  ChatViewModel.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 30/11/2021.
//

import Foundation

final class ChatViewModel: ObservableObject {
    
    @Published var allConversations: [ConversationData] = []
    
    func fetchAllUserConversations() {
        allConversations = []
        ConversationRepository.shared.fetchUserConversations { conversation in
            self.allConversations.append(conversation!)
            print(conversation!)
        }
    }
    
    func returnGoodName(user1: UserData, user2: UserData) -> String {
        if user1.userID == ConversationRepository.shared.currentUserID {
            return user2.name + " " + user2.lastName
        } else {
            return user1.name + " " + user1.lastName
        }
    }
    
    func returnGoodPicture(user1: UserData, user2: UserData) -> String {
        if user1.userID == ConversationRepository.shared.currentUserID {
            return user2.picture
        } else {
            return user1.picture
        }
    }
    
    func returnGoodUser(user1: UserData, user2: UserData) -> UserData {
        if user1.userID == ConversationRepository.shared.currentUserID {
            return user2
        } else {
            return user1
        }
    }
}
