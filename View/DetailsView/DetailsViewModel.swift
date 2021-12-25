//
//  DetailsViewModel.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 16/11/2021.
//

import Foundation

final class DetailsViewModel: ObservableObject {
    
    var id = ""
    @Published var gameInfo: ItemInfo?
    @Published var libraryButtonText = Constantes.addLibrary
    @Published var wishListButtonText = Constantes.addWish
    @Published var wishID = [String]()
    @Published var libraryID = [String]()
    
    func getDetail() {
        gameInfo = nil
        ApiService.shared.getGameByID(id: id) { result in
            switch result {
                case .success(let info):
                    self.gameInfo = info
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func addOrRemove(id: String, type: String) {
        UserRepository.shared.addOrRemove(id: id, type: type)
    }
    
    // get the user games and check if the game is already in wishlist or library
    func getIDs(type: String) {
        UserRepository.shared.fetchUserGame(type: type, user: AuthRepository.shared.userID!) { iDs in
            if type == Constantes.gameType[0] {
                self.checkLibrary(idArray: iDs)
            } else {
                self.checkWishlist(idArray: iDs)
            }
        }
    }
    
    // check if game is already in library or not to change Button Label
    private func checkLibrary(idArray: [String]) {
        libraryID = idArray
        var index = 0
        for game in libraryID {
            if game == id {
                index += 1
            }
        }
        libraryButtonText = index == 0 ? Constantes.addLibrary : Constantes.removeLibrary
    }
    
    // check if game is already in wishList or not to change Button Label
    private func checkWishlist(idArray: [String]) {
        wishID = idArray
        var index = 0
        for game in wishID {
            if game == id {
                index += 1
            }
        }
        wishListButtonText = index == 0 ? Constantes.addWish : Constantes.removeWish
    }
    
    func gameYear() -> String {
        return Constantes.year + (gameInfo?.yearpublished?.value ?? "?")
    }
    
    func players() -> String {
        return Constantes.player + (gameInfo?.minplayers.value ?? "") + "-" + (gameInfo?.maxplayers.value ?? "")
    }
    
    func playTime() -> String {
        return Constantes.time + (gameInfo?.minplaytime.value ?? "") + "-" + (gameInfo?.maxplaytime.value ?? "")
    }
    
    func gamePicture() -> String {
        return gameInfo?.image ?? Constantes.defaultGamePicture
    }
    
    func description() -> String {
        return gameInfo?.itemDescription ?? Constantes.noDescription
    }
    
}
