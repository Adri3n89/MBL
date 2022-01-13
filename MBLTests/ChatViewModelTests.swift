//
//  ChatViewModelTests.swift
//  ApiServiceTest
//
//  Created by Adrien PEREA on 01/01/2022.
//

import Foundation
@testable import MBL
import XCTest

class ChatViewModelTests: XCTestCase {

    var chatViewModel = ChatViewModel()
    
    override func setUp() {
        chatViewModel = ChatViewModel()
    }
    
    func testFetchConversationWithOne() {
        chatViewModel.conversationRepo = ConversationRepositoryMock(currentUserID: nil, createConversationString: nil, conversationData: ConversationData(conversationID: "123", user1ID: "1", user2ID: "2"))
        
        chatViewModel.fetchAllUserConversations()
        
        XCTAssertEqual(chatViewModel.allConversationsDate.count, 1)
        XCTAssertEqual(chatViewModel.allConversationsDate[0].conversationID, "123")
    }
    
    func testFetchConversationWithOneAnd2Messages() {
        chatViewModel.conversationRepo = ConversationRepositoryMock(currentUserID: nil, createConversationString: nil, conversationData: ConversationData(id: UUID(), conversationID: "12345", user1ID: "123", user2ID: "234", messages: [Message(text: "Au revoir", date: "2022-01-01 09:01:10", userID: "123"), Message(text: "Bonjour", date: "2022-01-01 08:01:10", userID: "234")], user1: nil, user2: nil))
        
        chatViewModel.fetchAllUserConversations()
        
        XCTAssertEqual(chatViewModel.allConversationsDate.count, 1)
        XCTAssertEqual(chatViewModel.allConversationsDate[0].conversationID, "12345")
        XCTAssertEqual(chatViewModel.allConversationsDate[0].messages![0].text, "Bonjour")
        XCTAssertEqual(chatViewModel.allConversationsDate[0].messages![0].userID, "234")
    }
    
    func testFetchConversationWithOneAnd0Message() {
        chatViewModel.conversationRepo = ConversationRepositoryMock(currentUserID: nil, createConversationString: nil, conversationData: ConversationData(id: UUID(), conversationID: "12345", user1ID: "123", user2ID: "234", messages: nil))
        
        chatViewModel.fetchAllUserConversations()
        
        XCTAssertEqual(chatViewModel.allConversationsDate.count, 1)
    }
    
    func testFetchConversationWithNoConversation() {
        chatViewModel.conversationRepo = ConversationRepositoryMock(currentUserID: nil, createConversationString: nil, conversationData: nil)
        
        chatViewModel.fetchAllUserConversations()
        
        XCTAssertEqual(chatViewModel.allConversationsDate.count, 0)
    }
    
    func testReturnGoodInfoWithUser1ID() {
        chatViewModel.allConversationsDate = [ConversationDate(id: UUID(), conversationID: "convID", user1ID: "123", user2ID: "234", messages: nil, user1: UserData(name: "Adrien", lastName: "PEREA", userID: "123", city: "Paris", picture: "pic1", refPic: "refPic1"), user2: UserData(name: "Toto", lastName: "Dutronc", userID: "234", city: "Nice", picture: "pic2", refPic: "refPic2"))]
        
        XCTAssertEqual(chatViewModel.returnGoodName(chatViewModel.allConversationsDate[0], userID: "123"), "Toto Dutronc")
        XCTAssertEqual(chatViewModel.returnGoodPicture(chatViewModel.allConversationsDate[0], userID: "123"), "pic2")
        XCTAssertEqual(chatViewModel.returnGoodUser(chatViewModel.allConversationsDate[0], userID: "123"), chatViewModel.allConversationsDate[0].user2)
    }
    
    func testReturnGoodInfoWithUser2ID() {
        chatViewModel.allConversationsDate = [ConversationDate(id: UUID(), conversationID: "convID", user1ID: "123", user2ID: "234", messages: nil, user1: UserData(name: "Adrien", lastName: "PEREA", userID: "123", city: "Paris", picture: "pic1", refPic: "refPic1"), user2: UserData(name: "Toto", lastName: "Dutronc", userID: "234", city: "Nice", picture: "pic2", refPic: "refPic2"))]
        
        XCTAssertEqual(chatViewModel.returnGoodName(chatViewModel.allConversationsDate[0], userID: "234"), "Adrien PEREA")
        XCTAssertEqual(chatViewModel.returnGoodPicture(chatViewModel.allConversationsDate[0], userID: "234"), "pic1")
        XCTAssertEqual(chatViewModel.returnGoodUser(chatViewModel.allConversationsDate[0], userID: "234"), chatViewModel.allConversationsDate[0].user1)
    }
   
}
