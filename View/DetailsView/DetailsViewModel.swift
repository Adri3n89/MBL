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
    
    func addToLibrary(id: String) {
        AuthRepository.shared.addToLibrary(id: id)
    }
    
    func addToWishlist(id: String) {
        AuthRepository.shared.addToWishlist(id: id)
    }
    
    func getLibraryID() {
        AuthRepository.shared.fetchUserGame(type: Constantes.gameType[0], user: AuthRepository.shared.userID!) { libraryID in
            self.libraryID = libraryID
            self.checkLibrary()
        }
    }
    
    func getWishID() {
        AuthRepository.shared.fetchUserGame(type: Constantes.gameType[1], user: AuthRepository.shared.userID!) { wishID in
            self.wishID = wishID
            self.checkWishlist()
        }
    }
    
    private func checkLibrary() {
        var index = 0
        for game in libraryID {
            if game == id {
                index += 1
            }
        }
        libraryButtonText = index == 0 ? Constantes.addLibrary : Constantes.removeLibrary
    }
    
    private func checkWishlist() {
        var index = 0
        for game in wishID {
            if game == id {
                index += 1
            }
        }
        wishListButtonText = index == 0 ? Constantes.addWish : Constantes.removeWish
    }
    
    func gameYear() -> String {
        return Constantes.year + (gameInfo?.yearpublished.value ?? "?")
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
