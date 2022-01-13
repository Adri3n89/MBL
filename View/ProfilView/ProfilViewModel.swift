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
    @Published var showError = false
    @Published var sourceType: UIImagePickerController.SourceType = .photoLibrary
    var error = ""
    var userRepo: UserRepositoryProvider = UserRepository()
    var authRepo: AuthRepositoryProvider = AuthRepository()
    var apiService = ApiService()
    var cancellable = Set<AnyCancellable>()
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // get games info from the array ID choose
    private func getGames(type: String) {
        for gameID in type == Constantes.gameType[0] ? libraryID : wishID {
           apiService.getGames(gameID: gameID)
               .receive(on: DispatchQueue.main)
               .sink { completion in
                   switch completion {
                   case .failure(let error):
                       self.error = error.localizedDescription
                       self.showError = true
                   case .finished:
                       self.showError = false
                   }
               } receiveValue: { game in
                   // check if the game is already in the array and don't add it again
                   if type == Constantes.gameType[0] {
                       if (!self.libraryGames.contains { $0.id == game.id}) { self.libraryGames.append(game) }
                   } else {
                       if (!self.wishGames.contains { $0.id == game.id}) { self.wishGames.append(game) }
                   }
               }
               .store(in: &cancellable)
       }
    }
    
    // fetch game ID from library or wishList in array
    func fetchID(type: String) {
       userRepo.fetchUserGame(type: type, user: authRepo.userID!) { IDs in
           if type == Constantes.gameType[0] {
               self.libraryID = IDs
           } else {
               self.wishID = IDs
           }
            self.getGames(type: type)
        }
    }
    
    // sign out the Firebase session and go to logIn screen
    func logOut() {
        authRepo.logOut()
    }
    
    // fetch currentuser info from Firebase
    func fetchUserInfo() {
        userRepo.fetchUserInfo(user: authRepo.userID!) { userInfo in
            self.userInfo.city = userInfo.city
            self.userInfo.lastName = userInfo.lastName
            self.userInfo.name = userInfo.name
            self.userInfo.picture = userInfo.picture
            self.userInfo.refPic = userInfo.refPic
            self.userInfo.userID = userInfo.userID
        }
    }
    
    // return the good type game to show
    func gameToShow() -> [GameData] {
        return type == Constantes.gameType[0] ? libraryGames : wishGames
    }
    
}
