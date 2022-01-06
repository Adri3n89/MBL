//
//  SignUpViewModelTests.swift
//  MBLTests
//
//  Created by Adrien PEREA on 04/01/2022.
//

import XCTest
@testable import MBL
import CoreLocation
import MapKit

class SignUpViewModelTests: XCTestCase {

   var signUpViewModel = SignUpViewModel()
    
    func testSignUpWithNoPlacemark() {
        signUpViewModel.signUp(geoCoder: GeoCoderMock())

        XCTAssertTrue(signUpViewModel.showError)
        XCTAssertEqual(signUpViewModel.error, Constantes.errorAdress)
    }

//    func testSignUpWithPlacemark() {
//        signUpViewModel.authRepo = AuthRepositoryMock()
//        signUpViewModel.userRepo = UserRepositoryMock()
//        signUpViewModel.signUp(geoCoder: GeoCoderMock())
//
//
//
//    }

}

