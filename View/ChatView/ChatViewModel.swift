//
//  ChatViewModel.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 30/11/2021.
//

import Foundation

final class ChatViewModel: ObservableObject {
    
    @Published var allConversationsDate: [ConversationDate] = []
    var conversationRepo: ConversationRepositoryProvider = ConversationRepository()
    
    // fetch all the current user conversations from Firebase
    func fetchAllUserConversations() {
        allConversationsDate = []
        conversationRepo.fetchUserConversations { conversation in
            guard let conversation = conversation else {return}
            self.allConversationsDate.append(ConversationDate(id: UUID(), conversationID: conversation.conversationID, user1ID: conversation.user1ID, user2ID: conversation.user2ID, messages: self.filterMessages(conversation: conversation), user1: conversation.user1, user2: conversation.user2))
            self.allConversationsDate = self.allConversationsDate.sorted(by: {
                ($0.messages?.last?.date ?? Date(timeIntervalSince1970: 0)).compare($1.messages?.last?.date ?? Date(timeIntervalSince1970: 0)) == .orderedDescending
            })
        }
    }
    
    // functions to keep the view clear and make the verification of who is the other user in the conversation
    
    func returnGoodName(_ conversation: ConversationDate, userID: String) -> String {
        if conversation.user1!.userID == userID {
            return conversation.user2!.name + " " + conversation.user2!.lastName
        } else {
            return conversation.user1!.name + " " + conversation.user1!.lastName
        }
    }
    
    func returnGoodPicture(_ conversation: ConversationDate, userID: String) -> String {
        if conversation.user1!.userID == userID {
            return conversation.user2!.picture
        } else {
            return conversation.user1!.picture
        }
    }
    
    func returnGoodUser(_ conversation: ConversationDate, userID: String) -> UserData {
        if conversation.user1!.userID == userID {
            return conversation.user2!
        } else {
            return conversation.user1!
        }
    }
    
    func filterMessages(conversation: ConversationData) -> [MessageDate] {
        var messages = [MessageDate]()
        if conversation.messages != nil {
            for message in conversation.messages! {
                messages.append(MessageDate(text: message.text, date: message.date.stringToDate(), userID: message.userID ))
            }
            messages = messages.sorted(by: {
                $0.date.compare($1.date) == .orderedAscending
            })
            return messages
        } else {
            return []
        }
    }
}
