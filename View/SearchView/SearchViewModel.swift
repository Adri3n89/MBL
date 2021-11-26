//
//  SearchViewModel.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 17/11/2021.
//

import Foundation

final class SearchViewModel: ObservableObject {
    
    @Published var gameName: String = ""
    @Published var searchResult: [ItemResult] = []
    @Published var error = ""
    @Published var showError = false
    
    func searchGame() {
        // TODO - encoder le text pour ne pas avoir d'erreur avec les ' et - 
        ApiService.shared.searchGameName(name: gameName.replacingOccurrences(of: " ", with: "_")) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let games):
                        self.searchResult = games
                    case .failure(let error):
                        self.error = error.localizedDescription
                        self.showError = true
                }
            }
        }
    }
    
}
