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
    
    func testCreateConversationAlreadyExist() {
        publicProfilViewModel.conversationRepo = ConversationRepositoryMock(currentUserID: nil, createConversationString: Constantes.alreadyConversation, conversationData: nil)
        
        publicProfilViewModel.createConversation()
        
        XCTAssertEqual(publicProfilViewModel.message, Constantes.alreadyConversation)
        XCTAssertTrue(publicProfilViewModel.showMessage)
    }
    
    func testCreateConversation() {
        publicProfilViewModel.conversationRepo = ConversationRepositoryMock(currentUserID: nil, createConversationString: Constantes.createConversation, conversationData: nil)
        
        publicProfilViewModel.createConversation()
        
        XCTAssertEqual(publicProfilViewModel.message, Constantes.createConversation)
        XCTAssertTrue(publicProfilViewModel.showMessage)
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
