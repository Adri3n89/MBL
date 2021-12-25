//
//  SearchViewModel.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 17/11/2021.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {
    
    @Published var gameName: String = ""
    @Published var searchResult: [ItemResult] = []
    @Published var error = ""
    @Published var showError = false
    @Published var isLoading = false
    var cancellable = Set<AnyCancellable>()
    
    func searchGame() {
        // convert the caracteres to the good format for the api request
        searchResult = []
        let okayChars : Set<Character> =
                Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-*=(),.:!_")
        let name = gameName.replacingOccurrences(of: " ", with: "_")
        let name2 = String(name.filter {okayChars.contains($0) })
        ApiService.shared.searchGameName(name: name2)
            .receive(on: DispatchQueue.main)
            .sink { error in
                print(error)
            } receiveValue: { result in
                self.searchResult = result
                self.isLoading = false
                if result.count == 0 {
                    self.error = "No Result"
                    self.showError = true
                }
            }
            .store(in: &cancellable)
    }
    
}
