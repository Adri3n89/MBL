//
//  ConversationRepositoryProvider.swift
//  MBL (iOS)
//
//  Created by Adrien PEREA on 01/01/2022.
//

import Foundation

protocol ConversationRepositoryProvider {
    var currentUserID: String? { get }
    func createConversation(user: String)
    func searchIfConversationAlreadyExist(user: String, completed: @escaping (String) -> Void)
    func addMessage(idConversation: String, text: String, date: String)
    func fetchUserConversations(completed: @escaping (ConversationData?) -> Void)
    func fetchConversation(conversationID: String, completed: @escaping (ConversationData) -> Void)
}
