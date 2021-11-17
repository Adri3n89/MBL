//
//  ProfilViewModel.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 16/11/2021.
//

import Foundation
import SwiftUI

final class ProfilViewModel: ObservableObject {
    
    @Published var type = "library"
    @Published var wishGames: [GameData] = []
    @Published var libraryGames: [GameData] = []
    @Published var libraryID: [String] = []
    @Published var wishID: [String] = []
    var allType = ["library", "wishlist"]
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    func getWishGame() {
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
        AuthRepository.shared.fetchUserGame(type: "Library") { libraryID in
            self.libraryID = libraryID
            self.getLibraryGame()
        }
    }
    
    func fetchWishlistID() {
        AuthRepository.shared.fetchUserGame(type: "Wishlist") { wishID in
            self.wishID = wishID
            self.getWishGame()
        }
    }
    
}
