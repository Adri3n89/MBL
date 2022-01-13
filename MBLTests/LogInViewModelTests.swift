//
//  LogInViewModelTests.swift
//  ApiServiceTest
//
//  Created by Adrien PEREA on 31/12/2021.
//

import Foundation
@testable import MBL
import XCTest

class LogInViewModelTests: XCTestCase {
    
    var logInViewModel = LogInViewModel()
    
    override func setUp() {
        logInViewModel = LogInViewModel()
    }
 
    func testLogInWithSucces() {
        logInViewModel.authRepo = AuthRepositoryMock(isSignedIn: nil, signIn: .success(true), forgotString: nil, signUp: nil)
        
        logInViewModel.signIn()
        
        XCTAssertEqual(logInViewModel.error, "")
        XCTAssertFalse(logInViewModel.showError)
        XCTAssertTrue(logInViewModel.isPresented)
    }
    
    func testLogInWithError() {
        logInViewModel.authRepo = AuthRepositoryMock(isSignedIn: nil, signIn: .failure(NetworkError.noResult), forgotString: nil, signUp: nil)
        
        logInViewModel.signIn()
        
        XCTAssertEqual(logInViewModel.error, "No Result")
        XCTAssertTrue(logInViewModel.showError)
        XCTAssertFalse(logInViewModel.isPresented)
    }
    
}
