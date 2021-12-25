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
    @Published var isLoading = false
    
    func searchGame() {
        // convert the caractere to the good format for the api request
        searchResult = []
        let okayChars : Set<Character> =
                Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-*=(),.:!_")
        let name = gameName.replacingOccurrences(of: " ", with: "_")
        let name2 = String(name.filter {okayChars.contains($0) })
        ApiService.shared.searchGameName(name: name2) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let games):
                        self.isLoading.toggle()
                        self.searchResult = games
                    case .failure(let error):
                        self.isLoading.toggle()
                        self.error = error.localizedDescription
                        self.showError = true
                }
            }
        }
    }
    
}
