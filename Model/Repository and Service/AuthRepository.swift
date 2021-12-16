//
//  AuthRepository.swift
//  MGL
//
//  Created by Adrien PEREA on 13/11/2021.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

final class AuthRepository: ObservableObject {
    
    static let shared = AuthRepository()
    private let auth = Auth.auth()
    var userID: String? {
        get {
            return auth.currentUser?.uid
        }
    }
    
    func isSignIn() -> Bool {
        if userID != nil {
            return true
        } else {
            return false
        }
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
    
    func forgotPassword(email: String, completed: @escaping (String) -> Void) {
        auth.sendPasswordReset(withEmail: email) { error in
            guard let error = error else {
                completed(Constantes.resetMail)
                return
            }
            completed(error.localizedDescription)
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
    
    func logOut() {
        do { try auth.signOut()
        }
        catch { print(error.localizedDescription) }
    }
    
}
