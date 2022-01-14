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
    var conversationRepo: ConversationRepositoryProvider = ConversationRepository()
    
    init(userInfo: UserData, conversationID: String) {
        self.userInfo = userInfo
        self.conversationID = conversationID
    }
    
    // send message , save it on firebase and refetch the new conversation
    func sendMessage() {
        conversationRepo.addMessage(idConversation: conversationID, text: newMessage, date: Date().dateAndTimetoString())
        newMessage = ""
        fetchConversation()
    }
    
    // fetch the conversation and filter it to show the last on bottom
    func fetchConversation() {
        messages = []
        conversationRepo.fetchConversation(conversationID: conversationID) { conversation in
            self.filterMessages(conversation: conversation)
        }
    }
    
    // filter messages to put the last message at the end of the array
    private func filterMessages(conversation: ConversationData) {
        if conversation.messages != nil {
            conversation.messages!.forEach { message in
                self.messages.append(MessageDate(text: message.text, date: message.date.stringToDate(), userID: message.userID ))
            }
            self.messages = self.messages.sorted(by: { $0.date.compare($1.date) == .orderedAscending })
        }
    }
    
    // return user name and last name
    func userName() -> String {
        return userInfo.name + " " + userInfo.lastName
    }

}
