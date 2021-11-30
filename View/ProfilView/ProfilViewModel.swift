//
//  ProfilViewModel.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 16/11/2021.
//

import Foundation
import SwiftUI
import UIKit

final class ProfilViewModel: ObservableObject {
    
    // trier les ID library et wishlist par numero pour ne pas qu'ils changent d'ordre
    
    @Published var type = Constantes.gameType[0]
    @Published var wishGames: [GameData] = []
    @Published var libraryGames: [GameData] = []
    @Published var libraryID: [String] = []
    @Published var wishID: [String] = []
    @Published var userInfo: UserData = UserData(name: "", lastName: "", userID: "", city: "", picture: "", refPic: "")
    @Published var showAlert = false
    @Published var showPicker = false
    @Published var sourceType: UIImagePickerController.SourceType = .photoLibrary
    var allType = Constantes.gameType
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private func getWishGame() {
        ApiService.shared.getWish(wishID: wishID) { result in
            switch result {
                case .success(let game):
                    self.wishGames = game
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
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
        AuthRepository.shared.fetchUserGame(type: Constantes.gameType[0], user: AuthRepository.shared.userID!) { libraryID in
            self.libraryID = libraryID
            self.getLibraryGame()
        }
    }
    
    func fetchWishlistID() {
        AuthRepository.shared.fetchUserGame(type: Constantes.gameType[1], user: AuthRepository.shared.userID!) { wishID in
            self.wishID = wishID
            self.getWishGame()
        }
    }
    
    func logOut() {
        AuthRepository.shared.logOut()
    }
    
    func fetchUserInfo() {
        AuthRepository.shared.fetchUserInfo(user: AuthRepository.shared.userID!) { userInfo in
            self.userInfo.city = userInfo.city
            self.userInfo.lastName = userInfo.lastName
            self.userInfo.name = userInfo.name
            self.userInfo.picture = userInfo.picture
        }
    }
    
    func updatePicture() {
        showAlert = true
    }
    
}
