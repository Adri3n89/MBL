//
//  ConversationViewModel.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 30/11/2021.
//

import Foundation

final class ConversationViewModel: ObservableObject {
    
    @Published var messages: [MessageDate] = []
    @Published var userInfo: UserData
    @Published var newMessage: String = ""
    @Published var conversationID: String
    
    init(userInfo: UserData, conversationID: String) {
        self.userInfo = userInfo
        self.conversationID = conversationID
    }
    
    // return user name and last name
    func userName() -> String {
        return userInfo.name + " " + userInfo.lastName
    }
    
    // send message , save it on firebase and refetch the new conversation
    func sendMessage() {
        ConversationRepository.shared.addMessage(idConversation: conversationID, text: newMessage, date: Date().dateAndTimetoString())
        newMessage = ""
        fetchConversation()
    }
    
    // fetch the conversation and filter it to show the last on bottom
    func fetchConversation() {
        messages = []
        ConversationRepository.shared.fetchConversation(conversationID: conversationID) { conversation in
            if conversation.messages != nil {
                for message in conversation.messages! {
                    self.messages.append(MessageDate(text: message.text, date: message.date.stringToDate(), userID: message.userID ))
                }
                self.messages = self.messages.sorted(by: {
                    $0.date.compare($1.date) == .orderedAscending
                })
            }
        }
    }

}
