//
//  ChatViewModel.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 30/11/2021.
//

import Foundation

final class ChatViewModel: ObservableObject {
    
    @Published var allConversations: [ConversationData] = []
    
    // fetch all the current user conversations from Firebase
    func fetchAllUserConversations() {
        allConversations = []
        ConversationRepository.shared.fetchUserConversations { conversation in
            guard let conversation = conversation else {return}
            self.allConversations.append(conversation)
            // TODO: filtrer par dernier message de conversation
//            self.allConversations = self.allConversations.sorted {
//                $0.messages!.last!.date.stringToDate() < $1.messages!.last!.date.stringToDate()
//            }
//            self.allConversations = self.allConversations.sorted {
//                $0.messages?.last?.date.stringToDate().compare(($1.messages?.last?.date.stringToDate())!) == .orderedAscending
//            }
        }
    }
    
    // functions to keep the view clear and make the verification of who is the other user in the conversation
    
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
