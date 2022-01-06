//
//  AuthRepositoryProvider.swift
//  ApiServiceTest
//
//  Created by Adrien PEREA on 31/12/2021.
//

import Foundation

protocol AuthRepositoryProvider {
    
    var userID: String? { get }
    func isSignIn() -> Bool
    
    func signIn(email: String, password: String, completed: @escaping (Result<Bool,Error>) -> Void)
    
    func forgotPassword(email: String, completed: @escaping (String) -> Void)
    
    func signUp(email: String, password: String, name: String, lastName: String, city: String, completed: @escaping (Result<Bool,Error>) -> Void)
    
    func logOut()
}
