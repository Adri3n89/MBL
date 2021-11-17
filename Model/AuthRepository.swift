//
//  AuthRepository.swift
//  MGL
//
//  Created by Adrien PEREA on 13/11/2021.
//

import Foundation
import FirebaseAuth

final class AuthRepository: ObservableObject {
    
    static let shared = AuthRepository()
    private let auth = Auth.auth()
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String, completed: @escaping (Result<AuthDataResult,Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                completed(.failure(error!))
                return
            }
            completed(.success(result!))
        }
    }
    
    func signUp(email: String, password: String, name: String, lastName: String, city: String, completed: @escaping (Result<AuthDataResult,Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                completed(.failure(error!))
                return
            }
            completed(.success(result!))
        }
    }
}
