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
    
    func testFetchLibraryIDWithGames() {
        profilViewModel.userRepo = UserRepositoryMock(userGame: ["123"], userData: UserData(name: "J", lastName: "D", userID: "123", city: "PARIS", picture: "pic", refPic: "refpic"), allUsers: [])
        profilViewModel.libraryID = []
        profilViewModel.apiService = ApiServiceMock(resultHotGame: nil, resultGetGames: .success(GameData(name: "Jeu", year: "2020", id: "123", rank: "", image: "image", description: "description", minPlayer: "2", maxPlayer: "4", minTime: "34", maxTime: "54")), resultSearchGame: nil)
        
        profilViewModel.fetchLibraryID()
        
        XCTAssertEqual(profilViewModel.libraryID, ["123"])
        XCTAssertEqual(profilViewModel.libraryGames.count, 1)
    }
    
    func testFetchWishIDWithGames() {
        profilViewModel.userRepo = UserRepositoryMock(userGame: ["123"], userData: UserData(name: "J", lastName: "D", userID: "123", city: "PARIS", picture: "pic", refPic: "refpic"), allUsers: [])
        profilViewModel.wishID = []
        profilViewModel.apiService = ApiServiceMock(resultHotGame: nil, resultGetGames: .success(GameData(name: "Jeu", year: "2020", id: "123", rank: "", image: "image", description: "description", minPlayer: "2", maxPlayer: "4", minTime: "34", maxTime: "54")), resultSearchGame: nil)
        profilViewModel.fetchWishlistID()
        
        XCTAssertEqual(profilViewModel.wishID, ["123"])
        XCTAssertEqual(profilViewModel.wishGames.count, 1)

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

}
