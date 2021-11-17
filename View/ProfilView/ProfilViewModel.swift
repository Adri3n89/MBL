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
    
    let favoriteID: [String] = ["1345","2930", "12345"]
    let wishID: [String] = ["3245", "2134", "9230", "99999"]
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
    
    func getLibraryGame() {
        ApiService.shared.getFavorite(favoritesID: favoriteID) { result in
            switch result {
                case .success(let game):
                    self.libraryGames = game
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
}
