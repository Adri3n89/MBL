//
//  ConvertStringTests.swift
//  ApiServiceTest
//
//  Created by Adrien PEREA on 31/12/2021.
//

import Foundation
import XCTest
@testable import MBL

class ConvertStringTests: XCTestCase {
    
    func testConvertStringForSearch() {
        
        var name = "7 Wonders"
        var name2 = "Pirate's Treasure"
        var name3 = "Ca/tan:"
        
        name = name.convertForSearch()
        name2 = name2.convertForSearch()
        name3 = name3.convertForSearch()
        
        XCTAssertEqual(name, "7_Wonders")
        XCTAssertEqual(name2, "Pirates_Treasure")
        XCTAssertEqual(name3, "Catan:")
        
    }
    
}
