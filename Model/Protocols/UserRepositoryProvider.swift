//
//  UserRepositoryProvider.swift
//  MBL (iOS)
//
//  Created by Adrien PEREA on 31/12/2021.
//

import Foundation

protocol UserRepositoryProvider {
    func fetchUserGame(type: String, user: String, completed: @escaping ([String]) -> Void)
    func fetchUserInfo(user: String,completed: @escaping (UserData) -> Void)
    func fetchAllUsers(completed: @escaping ([UserData]) -> Void)
    func createUserInfo(email: String, name: String, lastName: String, city: String)
    func updateProfil(key: String, value: String)
    func addOrRemove(id: String, type: String, completed: @escaping (String) -> Void)
}
