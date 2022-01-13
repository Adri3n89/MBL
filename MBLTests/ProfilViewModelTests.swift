//
//  ProfilViewModelTests.swift
//  ApiServiceTest
//
//  Created by Adrien PEREA on 30/12/2021.
//

import XCTest
@testable import MBL

class ProfilViewModelTests: XCTestCase {

    var profilViewModel = ProfilViewModel()
    
    override func setUp() {
        profilViewModel = ProfilViewModel()
    }
    
    func testGameToShowWithTypeLibrary() {
        profilViewModel.type = "Library"
        
        profilViewModel.wishGames = [GameData(name: "wish", year: "1990", id: "123", rank: "1", image: "image", description: "description", minPlayer: "2", maxPlayer: "4", minTime: "30", maxTime: "45")]
        profilViewModel.libraryGames = [GameData(name: "library", year: "2020", id: "134554", rank: "210", image: "img", description: "desc", minPlayer: "4", maxPlayer: "6", minTime: "10", maxTime: "120")]
        
        XCTAssertEqual(profilViewModel.gameToShow(), profilViewModel.libraryGames)
    }
    
    func testGameToShowWithTypeWishlist() {
        profilViewModel.type = "Wishlist"
        
        profilViewModel.wishGames = [GameData(name: "wish", year: "1990", id: "123", rank: "1", image: "image", description: "description", minPlayer: "2", maxPlayer: "4", minTime: "30", maxTime: "45")]
        profilViewModel.libraryGames = [GameData(name: "library", year: "2020", id: "134554", rank: "210", image: "img", description: "desc", minPlayer: "4", maxPlayer: "6", minTime: "10", maxTime: "120")]
        
        XCTAssertEqual(profilViewModel.gameToShow(), profilViewModel.wishGames)
    }
    
    func testGameToShowWithTypeLibraryAndNoGame() {
        profilViewModel.type = "Library"
        profilViewModel.wishGames = [GameData(name: "wish", year: "1990", id: "123", rank: "1", image: "image", description: "description", minPlayer: "2", maxPlayer: "4", minTime: "30", maxTime: "45")]
        profilViewModel.libraryGames = []
        
        XCTAssertEqual(profilViewModel.gameToShow(), profilViewModel.libraryGames)
        XCTAssertEqual(profilViewModel.gameToShow(), [])

    }
    
    func testGameToShowWithTypeWishlistAndNoGame() {
        profilViewModel.type = "Wishlist"
        profilViewModel.wishGames = []
        profilViewModel.libraryGames = [GameData(name: "library", year: "2020", id: "134554", rank: "210", image: "img", description: "desc", minPlayer: "4", maxPlayer: "6", minTime: "10", maxTime: "120")]
        
        XCTAssertEqual(profilViewModel.gameToShow(), profilViewModel.wishGames)
        XCTAssertEqual(profilViewModel.gameToShow(), [])
    }
    
    func testFetchUserInfo() {
        profilViewModel.userRepo = UserRepositoryMock(userGame: ["123", "1234"], userData: UserData(name: "John", lastName: "Doe", userID: "123", city: "PARIS", picture: "pic", refPic: "refpic"), allUsers: [])
        
        profilViewModel.fetchUserInfo()
        
        XCTAssertEqual(profilViewModel.userInfo.name, "John")
        XCTAssertEqual(profilViewModel.userInfo.lastName, "Doe")
        XCTAssertEqual(profilViewModel.userInfo.userID, "123")
        XCTAssertEqual(profilViewModel.userInfo.city, "PARIS")
        XCTAssertEqual(profilViewModel.userInfo.picture, "pic")
        XCTAssertEqual(profilViewModel.userInfo.refPic, "refpic")
    }
    
    func testFetchLibraryID() {
        profilViewModel.userRepo = UserRepositoryMock(userGame: ["123", "234"], userData: nil, allUsers: nil, addOrRemoveResult: nil)
        
        XCTAssertEqual(profilViewModel.libraryID, [])
        XCTAssertEqual(profilViewModel.wishID, [])
        
        profilViewModel.fetchID(type: "Library")
        
        XCTAssertEqual(profilViewModel.libraryID, ["123", "234"])
        XCTAssertEqual(profilViewModel.wishID, [])
    }
    
    func testFetchWishID() {
        profilViewModel.userRepo = UserRepositoryMock(userGame: ["123", "234"], userData: nil, allUsers: nil, addOrRemoveResult: nil)
        
        XCTAssertEqual(profilViewModel.libraryID, [])
        XCTAssertEqual(profilViewModel.wishID, [])
        
        profilViewModel.fetchID(type: "Wishlist")
        
        XCTAssertEqual(profilViewModel.libraryID, [])
        XCTAssertEqual(profilViewModel.wishID, ["123", "234"])
    }

}
