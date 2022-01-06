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
    
    func testFetchLibraryIDwith2Games() {
        publicProfilViewModel.userRepo = UserRepositoryMock(userGame: ["123"], userData: nil, allUsers: [])
        publicProfilViewModel.apiService = ApiServiceMock(resultHotGame: nil, resultGetGames: .success(GameData(name: "Jeu", year: "2020", id: "123", rank: "", image: "image", description: "description", minPlayer: "2", maxPlayer: "4", minTime: "34", maxTime: "54")), resultSearchGame: nil)
        
        XCTAssertEqual(publicProfilViewModel.libraryGames.count, 0)
        XCTAssertEqual(publicProfilViewModel.libraryID.count, 0)

        publicProfilViewModel.fetchLibraryID(user: "john")
        
        XCTAssertEqual(publicProfilViewModel.libraryID.count, 1)
        XCTAssertEqual(publicProfilViewModel.libraryID[0], "123")
        
        XCTAssertEqual(publicProfilViewModel.libraryGames.count, 1)

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
    
}
