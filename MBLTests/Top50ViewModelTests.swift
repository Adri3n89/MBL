//
//  Top50ViewModel.swift
//  ApiServiceTest
//
//  Created by Adrien PEREA on 01/01/2022.
//

@testable import MBL
import XCTest
import Combine

class Top50ViewModelTests: XCTestCase {

    var top50ViewModel = Top50ViewModel()
    
    func testGetTop50() {
        let expectation = XCTestExpectation(description: "changing queue")
        
        top50ViewModel.apiService = ApiServiceMock(resultHotGame: .success(Array(repeating: GameData(name: "Name", year: "2020", id: "123", rank: "1", image: "image", description: "description", minPlayer: "2", maxPlayer: "4", minTime: "45", maxTime: "56"), count: 10)), resultGetGames: nil, resultSearchGame: nil)
                
        top50ViewModel.getTop50()

        XCTAssertEqual(top50ViewModel.top50.count, 50)
        
        wait(for: [expectation], timeout: 10)
        
    }

}
