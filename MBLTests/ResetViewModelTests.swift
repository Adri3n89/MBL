//
//  ResetViewModelTests.swift
//  ApiServiceTest
//
//  Created by Adrien PEREA on 31/12/2021.
//

import XCTest
@testable import MBL

class ResetViewModelTests: XCTestCase {

    var resetViewModel = ResetViewModel()
    
    func testResetPassWord() {
        resetViewModel.authRepo = AuthRepositoryMock(id: nil, isSignedIn: nil, signIn: nil, forgotString: "password reset successfull", signUp: nil)
        
        resetViewModel.getNewPassword()
        XCTAssertEqual(resetViewModel.message, "password reset successfull")
        XCTAssertTrue(resetViewModel.showMessage)
    }

}
