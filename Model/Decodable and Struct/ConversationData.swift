//
//  ConversationData.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 30/11/2021.
//

import Foundation

struct ConversationData: Identifiable {
    var id = UUID()
    var conversationID: String
    var user1ID: String
    var user2ID: String
    var messages: [Message]?
    var user1: UserData?
    var user2: UserData?
}

struct Message: Identifiable {
    var id = UUID()
    var text: String
    var date: String
    var userID: String
}

struct MessageDate: Identifiable {
    var id = UUID()
    var text: String
    var date: Date
    var userID: String
}
