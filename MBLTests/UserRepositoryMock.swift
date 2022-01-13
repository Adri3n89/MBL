//
//  UserRepositoryMock.swift
//  ApiServiceTest
//
//  Created by Adrien PEREA on 31/12/2021.
//

import Foundation
@testable import MBL

struct UserRepositoryMock: UserRepositoryProvider {

    var userGame: [String]?
    var userData: UserData?
    var allUsers: [UserData]?
    var addOrRemoveResult: String?
    
    func fetchUserGame(type: String, user: String, completed: @escaping ([String]) -> Void) {
        completed(userGame!)
    }
    
    func fetchUserInfo(user: String, completed: @escaping (UserData) -> Void) {
        completed(userData!)
    }
    
    func fetchAllUsers(completed: @escaping ([UserData]) -> Void) {
        completed(allUsers!)
    }
    
    func createUserInfo(email: String, name: String, lastName: String, city: String) {}
    
    func updateProfil(key: String, value: String) {}
    
    func addOrRemove(id: String, type: String, completed: @escaping (String) -> Void) {
        completed(addOrRemoveResult!)
    }
    
    
}
