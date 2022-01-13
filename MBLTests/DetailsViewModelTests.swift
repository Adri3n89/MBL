//
//  DetailsViewModelTests.swift
//  ApiServiceTest
//
//  Created by Adrien PEREA on 31/12/2021.
//

import XCTest
@testable import MBL
import Combine

class DetailsViewModelTests: XCTestCase {

    var detailsViewModel = DetailsViewModel()
    
    override func setUp() {
        detailsViewModel = DetailsViewModel()
    }
    
    func testGetIDWithGameInLibrary() {
        detailsViewModel.id = "123"
        detailsViewModel.userRepo = UserRepositoryMock(userGame: ["123", "456"], userData: nil, allUsers: [])
        
        detailsViewModel.getIDs(type: "Wishlist")
        
        XCTAssertEqual(detailsViewModel.wishID, ["123", "456"])
        XCTAssertEqual(detailsViewModel.libraryID, [])
        
        detailsViewModel.getIDs(type: "Library")
        
        XCTAssertEqual(detailsViewModel.libraryID, ["123", "456"])
        XCTAssertEqual(detailsViewModel.libraryButtonText, Constantes.removeLibrary)
        XCTAssertEqual(detailsViewModel.wishListButtonText, Constantes.removeWish)
    }
    
    func testGetIDWithGameNotInLibrary() {
        detailsViewModel.id = "12345"
        detailsViewModel.userRepo = UserRepositoryMock(userGame: ["123", "456"], userData: nil, allUsers: [])
        
        detailsViewModel.getIDs(type: "Wishlist")
        
        XCTAssertEqual(detailsViewModel.wishID, ["123", "456"])
        XCTAssertEqual(detailsViewModel.libraryID, [])
        
        detailsViewModel.getIDs(type: "Library")
        
        XCTAssertEqual(detailsViewModel.libraryID, ["123", "456"])
        XCTAssertEqual(detailsViewModel.libraryButtonText, Constantes.addLibrary)
        XCTAssertEqual(detailsViewModel.wishListButtonText, Constantes.addWish)
    }
    
    func testWithNoGameInfo() {
        XCTAssertEqual(detailsViewModel.gameYear(), "")
        XCTAssertEqual(detailsViewModel.players(), "")
        XCTAssertEqual(detailsViewModel.playTime(), "")
        XCTAssertEqual(detailsViewModel.gamePicture(), "")
        XCTAssertEqual(detailsViewModel.description(), "")
    }
    
    func testWithGameInfo() {
        detailsViewModel.gameInfo = GameData(name: "Catan", year: "2020", id: "123", rank: "1", image: "image", description: "description", minPlayer: "2", maxPlayer: "4", minTime: "30", maxTime: "45")
        
        XCTAssertEqual(detailsViewModel.gameYear(), "Year: 2020")
        XCTAssertEqual(detailsViewModel.players(), "Players: 2-4")
        XCTAssertEqual(detailsViewModel.playTime(), "Estimate play time: 30-45")
        XCTAssertEqual(detailsViewModel.gamePicture(), "image")
        XCTAssertEqual(detailsViewModel.description(), "description")
    }
    
    func testAddGameToLibrary() {
        detailsViewModel.userRepo = UserRepositoryMock(userGame: nil, userData: nil, allUsers: nil, addOrRemoveResult: "added")
        
        detailsViewModel.addOrRemove(id: "123", type: "Library")
        
        XCTAssertEqual(detailsViewModel.result, "added")
    }
    
    func testRemoveGameToWishlist() {
        detailsViewModel.userRepo = UserRepositoryMock(userGame: nil, userData: nil, allUsers: nil, addOrRemoveResult: "removed")
        
        detailsViewModel.addOrRemove(id: "123", type: "Wishlist")
        
        XCTAssertEqual(detailsViewModel.result, "removed")
    }
    
}
