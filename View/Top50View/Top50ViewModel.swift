//
//  Top50ViewModel.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 16/11/2021.
//

import Foundation
import SwiftUI
import Combine

final class Top50ViewModel: ObservableObject {
    
    @Published var top50: [GameData] = []
    @Published var showError = false
    @Published var error: String = ""
    var cancellable = Set<AnyCancellable>()
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // fetch the TOP 50 games from the api in array
    func getTop50() {
        ApiService.shared.getHotGame(Constantes.urlTop50)
           .receive(on: DispatchQueue.main)
           .sink { completion in
               switch completion {
               case .failure(let error):
                   self.error = error.localizedDescription
                   self.showError = true
               case .finished: self.showError = false
               }
           } receiveValue: { top50 in
               self.top50 = top50
           }
           .store(in: &cancellable)
    }
    
}
