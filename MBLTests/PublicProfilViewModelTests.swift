//
//  PublicViewModelTests.swift
//  ApiServiceTest
//
//  Created by Adrien PEREA on 31/12/2021.
//

import XCTest
@testable import MBL

class PublicProfilViewModelTests: XCTestCase {

    var publicProfilViewModel = PublicProfilViewModel()
    
    override func setUp() {
        publicProfilViewModel = PublicProfilViewModel()
    }
    
    func testFetchUserInfo() {
        //given
        publicProfilViewModel.userRepo = UserRepositoryMock(userGame: [], userData: UserData(name: "John", lastName: "Doe", userID: "jd", city: "Paris", picture: "pic", refPic: "picref"), allUsers: [])
        
        // when
        publicProfilViewModel.fetchUserInfo(user: "jd")
        
        // then
        XCTAssertEqual(publicProfilViewModel.userInfo.name, "John")
        XCTAssertEqual(publicProfilViewModel.userInfo.lastName, "Doe")
        XCTAssertEqual(publicProfilViewModel.userInfo.userID, "jd")
        XCTAssertEqual(publicProfilViewModel.userInfo.city, "Paris")
        XCTAssertEqual(publicProfilViewModel.userInfo.refPic, "picref")
        XCTAssertEqual(publicProfilViewModel.userInfo.picture, "pic")
    }
    
    func testCreateConversation() {
        publicProfilViewModel.conversationRepo = ConversationRepositoryMock(currentUserID: nil, createConversationString: Constantes.alreadyConversation, conversationData: ConversationData(id: UUID(), conversationID: "12345", user1ID: "123", user2ID: "234", messages: [Message(text: "Au revoir", date: "2022-01-01 09:01:10", userID: "123"), Message(text: "Bonjour", date: "2022-01-01 08:01:10", userID: "123")], user1: nil, user2: nil))
        
        publicProfilViewModel.createConversation()
        
        XCTAssertEqual(publicProfilViewModel.conversation?.conversationID, "12345")
    }
    
    
    func testFetchLibraryIDwith2Games() {
        publicProfilViewModel.userRepo = UserRepositoryMock(userGame: ["1234", "2345"], userData: nil, allUsers: nil, addOrRemoveResult: nil)
        
        publicProfilViewModel.fetchLibraryID(user: "Toto")
        
        XCTAssertEqual(publicProfilViewModel.libraryID, ["1234", "2345"])
    }
    
    func testFetchLibraryIDwithNoGame() {
        publicProfilViewModel.userRepo = UserRepositoryMock(userGame: [], userData: nil, allUsers: nil, addOrRemoveResult: nil)
        
        publicProfilViewModel.fetchLibraryID(user: "Toto")
        
        XCTAssertEqual(publicProfilViewModel.libraryID, [])
    }
    
}
