//
//  AuthRepository.swift
//  MGL
//
//  Created by Adrien PEREA on 13/11/2021.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class AuthRepository: AuthRepositoryProvider {
    
    var auth = Auth.auth()
    var userID: String? {
        get {
            return Auth.auth().currentUser?.uid
        }
    }
    
    func isSignIn() -> Bool {
        if userID != nil {
            return true
        } else {
            return false
        }
    }
    
    func signIn(email: String, password: String, completed: @escaping (Result<Bool,Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                completed(.failure(error!))
                return
            }
            completed(.success(true))
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
    
    func signUp(email: String, password: String, name: String, lastName: String, city: String, completed: @escaping (Result<Bool,Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                completed(.failure(error!))
                return
            }
            completed(.success(true))
        }
    }
    
    func logOut() {
        do { try auth.signOut()
        }
        catch { print(error.localizedDescription) }
    }
}
