//
//  ProfilViewModel.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 16/11/2021.
//

import Foundation
import SwiftUI
import Combine

final class ProfilViewModel: ObservableObject {
    
    // TODO: trier les ID library et wishlist par numero pour ne pas qu'ils changent d'ordre
    @Published var type = Constantes.gameType[0]
    @Published var wishGames: [GameData] = []
    @Published var libraryGames: [GameData] = []
    @Published var libraryID: [String] = []
    @Published var wishID: [String] = []
    @Published var userInfo: UserData = UserData(name: "", lastName: "", userID: "", city: "", picture: "", refPic: "")
    @Published var showAlert = false
    @Published var showPicker = false
    @Published var showCity = false
    @Published var sourceType: UIImagePickerController.SourceType = .photoLibrary
    var cancellable = Set<AnyCancellable>()
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // get games info from the array ID choose
    private func getGames(type: String) {
        if type == Constantes.gameType[0] {
           for gameID in libraryID {
               ApiService.shared.getGames(gameID: gameID)
                   .receive(on: DispatchQueue.main)
                   .sink { error in
                       print(error)
                   } receiveValue: { game in
                       self.libraryGames.append(game)
                   }
                   .store(in: &cancellable)
           }
        } else {
           for gameID in wishID {
               ApiService.shared.getGames(gameID: gameID)
                   .receive(on: DispatchQueue.main)
                   .sink { error in
                       print(error)
                   } receiveValue: { game in
                       self.wishGames.append(game)
                   }
                   .store(in: &cancellable)
            }
        }
    }
    
    // fetch game ID from library in array
    func fetchLibraryID() {
        UserRepository.shared.fetchUserGame(type: Constantes.gameType[0], user: AuthRepository.shared.userID!) { libraryID in
            self.libraryID = libraryID
            self.getGames(type: Constantes.gameType[0])
        }
    }
    
    // fetch game ID from wishlist in array
    func fetchWishlistID() {
        UserRepository.shared.fetchUserGame(type: Constantes.gameType[1], user: AuthRepository.shared.userID!) { wishID in
            self.wishID = wishID
            self.getGames(type: Constantes.gameType[1])
        }
    }
    
    // sign out the Firebase session and go to logIn screen
    func logOut() {
        AuthRepository.shared.logOut()
    }
    
    // fetch currentuser info from Firebase
    func fetchUserInfo() {
        UserRepository.shared.fetchUserInfo(user: AuthRepository.shared.userID!) { userInfo in
            self.userInfo.city = userInfo.city
            self.userInfo.lastName = userInfo.lastName
            self.userInfo.name = userInfo.name
            self.userInfo.picture = userInfo.picture
            self.userInfo.refPic = userInfo.refPic
        }
    }
    
    // return the good type game to show
    func gameToShow() -> [GameData] {
        return type == Constantes.gameType[0] ? libraryGames : wishGames
    }
    
}
