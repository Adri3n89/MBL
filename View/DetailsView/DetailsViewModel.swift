//
//  DetailsViewModel.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 16/11/2021.
//

import Foundation
import Combine

final class DetailsViewModel: ObservableObject {
    
    var id = ""
    @Published var gameInfo: GameData?
    @Published var libraryButtonText = Constantes.addLibrary
    @Published var wishListButtonText = Constantes.addWish
    @Published var wishID = [String]()
    @Published var libraryID = [String]()
    var userRepo: UserRepositoryProvider = UserRepository()
    var authRepo: AuthRepositoryProvider = AuthRepository()
    var cancellable = Set<AnyCancellable>()
    var result = ""
    
    // get gameData from API from the ID passed when tapping on a game
    func getDetail() {
        gameInfo = nil
        ApiService.shared.getGames(gameID: id)
            .receive(on: DispatchQueue.main)
            .sink { error in
                print(error)
            } receiveValue: { game in
                self.gameInfo = game
            }
            .store(in: &cancellable)
    }
    
    // check the database if the game is already in library or wishlist to Add it or remove It
    func addOrRemove(id: String, type: String) {
        userRepo.addOrRemove(id: id, type: type) { result in
            self.result = result
        }
    }
    
    // get the user games and check if the game is already in wishlist or library
    func getIDs(type: String) {
        userRepo.fetchUserGame(type: type, user: authRepo.userID!) { iDs in
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
        libraryButtonText = libraryID.contains(id) ? Constantes.removeLibrary : Constantes.addLibrary
    }
    
    // check if game is already in wishList or not to change Button Label
    private func checkWishlist(idArray: [String]) {
        wishID = idArray
        wishListButtonText = wishID.contains(id) ? Constantes.removeWish : Constantes.addWish
    }
    
    // return the good string for the view
    func gameYear() -> String {
        guard let game = gameInfo else { return "" }
        return "\(Constantes.year)\(game.year)"
    }
    
    func players() -> String {
        guard let game = gameInfo else { return "" }
        return "\(Constantes.player)\(game.minPlayer)-\(game.maxPlayer)"
    }
    
    func playTime() -> String {
        guard let game = gameInfo else { return "" }
        return "\(Constantes.time)\(game.minTime)-\(game.maxTime)"
    }
    
    func gamePicture() -> String {
        guard let game = gameInfo else { return "" }
        return game.image
    }
    
    func description() -> String {
        guard let game = gameInfo else { return "" }
        return game.description
    }
    
}
