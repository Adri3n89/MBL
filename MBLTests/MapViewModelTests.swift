//
//  MapViewModelTests.swift
//  MBLTests
//
//  Created by Adrien PEREA on 12/01/2022.
//

import XCTest
@testable import MBL

class MapViewModelTests: XCTestCase {

    var mapViewModel = MapViewModel()
    
    override  func setUp() {
        mapViewModel = MapViewModel()
    }
    
    func testFetchAllUsers() {
        mapViewModel.userRepo = UserRepositoryMock(userGame: nil, userData: nil, allUsers: [UserData(name: "Toto", lastName: "Titi", userID: "123", city: "Paris", picture: "pic", refPic: "refPic"), UserData(name: "Tata", lastName: "Tete", userID: "234", city: "Lyon", picture: "pic2", refPic: "refPic2")], addOrRemoveResult: nil)
        
        mapViewModel.getAllUsers()
        
        XCTAssertEqual(mapViewModel.allUsers.count, 2)
        XCTAssertEqual(mapViewModel.allUsers[0].name, "Toto")
        XCTAssertEqual(mapViewModel.allUsers[1].name, "Tata")
    }

}
