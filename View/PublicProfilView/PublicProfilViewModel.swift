//
//  PublicProfilViewModel.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 21/11/2021.
//

import Foundation
import SwiftUI

final class PublicProfilViewModel: ObservableObject {
    
    @Published var type = "library"
    @Published var libraryGames: [GameData] = []
    @Published var libraryID: [String] = []
    @Published var userInfo: UserData = UserData(name: "", lastName: "", userID: "", city: "")
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private func getLibraryGame() {
        ApiService.shared.getLibrary(libraryID: libraryID) { result in
            switch result {
                case .success(let game):
                    self.libraryGames = game
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func fetchLibraryID() {
        AuthRepository.shared.fetchUserGame(type: "Library") { libraryID in
            self.libraryID = libraryID
            self.getLibraryGame()
        }
    }
    
    func fetchUserInfo() {
        AuthRepository.shared.fetchUserInfo { userInfo in
            self.userInfo.city = userInfo.city
            self.userInfo.lastName = userInfo.lastName
            self.userInfo.name = userInfo.name
        }
    }
    
}
