//
//  ConversationViewModelTests.swift
//  MBLTests
//
//  Created by Adrien PEREA on 04/01/2022.
//

import XCTest
@testable import MBL

class ConversationViewModelTests: XCTestCase {

    var conversationViewModel = ConversationViewModel(userInfo: UserData(name: "Adrien", lastName: "PEREA", userID: "123", city: "Paris", picture: "pic1", refPic: "refPic1"), conversationID: "12345")
    
    func testSendNewMessage() {
        conversationViewModel.newMessage = "Hello Adrien"
        conversationViewModel.conversationRepo = ConversationRepositoryMock(currentUserID: nil, createConversationString: nil, conversationData: ConversationData(id: UUID(), conversationID: "12345", user1ID: "123", user2ID: "234", messages: [Message(text: "Au revoir", date: "2022-01-01 09:01:10", userID: "123"), Message(text: "Bonjour", date: "2022-01-01 08:01:10", userID: "123")], user1: nil, user2: nil))
        
        conversationViewModel.sendMessage()
        
        XCTAssertEqual(conversationViewModel.newMessage, "")
    }
    
    func testFetchConversation() {
        conversationViewModel.conversationRepo = ConversationRepositoryMock(currentUserID: nil, createConversationString: nil, conversationData: ConversationData(id: UUID(), conversationID: "12345", user1ID: "123", user2ID: "234", messages: [Message(text: "Au revoir", date: "2022-01-01 09:01:10", userID: "123"), Message(text: "Bonjour", date: "2022-01-01 08:01:10", userID: "123")], user1: nil, user2: nil))
        
        conversationViewModel.fetchConversation()
        
        XCTAssertEqual(conversationViewModel.messages.count, 2)
        XCTAssertEqual(conversationViewModel.messages.first?.text, "Bonjour")
    }
    
    func testReturnUserName() {
        conversationViewModel.conversationRepo = ConversationRepositoryMock()
        XCTAssertEqual(conversationViewModel.userName(), "Adrien PEREA")
    }

}
