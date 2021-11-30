//
//  PublicProfilViewModel.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 21/11/2021.
//

import Foundation
import SwiftUI

final class PublicProfilViewModel: ObservableObject {
    
    @Published var libraryGames: [GameData] = []
    @Published var libraryID: [String] = []
    @Published var userInfo: UserData = UserData(name: "", lastName: "", userID: "", city: "", picture: "", refPic: "")
    
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
    
    func fetchLibraryID(user: String) {
        AuthRepository.shared.fetchUserGame(type: Constantes.gameType[0], user: user) { libraryID in
            self.libraryID = libraryID
            self.getLibraryGame()
        }
    }
    
    func fetchUserInfo(user: String) {
        AuthRepository.shared.fetchUserInfo(user: user) { userInfo in
            self.userInfo.city = userInfo.city
            self.userInfo.lastName = userInfo.lastName
            self.userInfo.name = userInfo.name
            self.userInfo.picture = userInfo.picture
        }
    }
    
}
