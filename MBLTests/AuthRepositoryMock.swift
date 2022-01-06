//
//  AuthRepositoryMock.swift
//  ApiServiceTest
//
//  Created by Adrien PEREA on 31/12/2021.
//

import Foundation
import Firebase
@testable import MBL

struct AuthRepositoryMock: AuthRepositoryProvider {
    var id: String?
    var userID: String? {
        get {
            return id
        }
    }
    var isSignedIn: Bool?
    var signIn: Result<Bool, Error>?
    var forgotString: String?
    var signUp: Result<Bool, Error>?
    
    func isSignIn() -> Bool {
        return isSignedIn!
    }
    
    func signIn(email: String, password: String, completed: @escaping (Result<Bool, Error>) -> Void) {
        completed(signIn!)
    }
    
    func forgotPassword(email: String, completed: @escaping (String) -> Void) {
        completed(forgotString!)
    }
    
    func signUp(email: String, password: String, name: String, lastName: String, city: String, completed: @escaping (Result<Bool, Error>) -> Void) {
        completed(signUp!)
    }
    
    func logOut() {
        
    }
    
    
}
