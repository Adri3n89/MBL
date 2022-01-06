//
//  ConversationRepositoryMock.swift
//  ApiServiceTest
//
//  Created by Adrien PEREA on 01/01/2022.
//

import Foundation
@testable import MBL

struct ConversationRepositoryMock: ConversationRepositoryProvider {
    var currentUserID: String?
    var createConversationString: String?
    var conversationData: ConversationData?
    
    func createConversation(user: String) {}
    
    func searchIfConversationAlreadyExist(user: String, completed: @escaping (String) -> Void) {
        completed(createConversationString!)
    }
    
    func addMessage(idConversation: String, text: String, date: String) {}
    
    func fetchUserConversations(completed: @escaping (ConversationData?) -> Void) {
        completed(conversationData)
    }
    
    func fetchConversation(conversationID: String, completed: @escaping (ConversationData) -> Void) {
        completed(conversationData!)
    }
    
    
}
