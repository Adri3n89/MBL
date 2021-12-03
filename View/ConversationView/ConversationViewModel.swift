//
//  ConversationViewModel.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 30/11/2021.
//

import Foundation

final class ConversationViewModel: ObservableObject {
    
    @Published var messages: [Message] = []
    @Published var userInfo: UserData
    @Published var newMessage: String = ""
    @Published var conversationID: String
    
    init(messages: [Message], userInfo: UserData, conversationID: String) {
        self.messages = messages
        self.userInfo = userInfo
        self.conversationID = conversationID
    }
    
    func userName() -> String {
        return userInfo.name + " " + userInfo.lastName
    }
    
    func sendMessage() {
        ConversationRepository.shared.addMessage(idConversation: conversationID, text: newMessage, date: Date().dateAndTimetoString())
        newMessage = ""
        fetchConversation()
    }
    
    func fetchConversation() {
        ConversationRepository.shared.fetchConversation(conversationID: conversationID) { conversation in
            self.messages = conversation.messages ?? []
        }
    }
}
