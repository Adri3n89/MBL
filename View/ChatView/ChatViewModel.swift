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
    
    func returnGoodName(_ conversation: ConversationData) -> String {
        if conversation.user1!.userID == ConversationRepository.shared.currentUserID {
            return conversation.user2!.name + " " + conversation.user2!.lastName
        } else {
            return conversation.user1!.name + " " + conversation.user1!.lastName
        }
    }
    
    func returnGoodPicture(_ conversation: ConversationData) -> String {
        if conversation.user1!.userID == ConversationRepository.shared.currentUserID {
            return conversation.user2!.picture
        } else {
            return conversation.user1!.picture
        }
    }
    
    func returnGoodUser(_ conversation: ConversationData) -> UserData {
        if conversation.user1!.userID == ConversationRepository.shared.currentUserID {
            return conversation.user2!
        } else {
            return conversation.user1!
        }
    }
}
