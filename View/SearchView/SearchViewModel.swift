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
    
    func searchGame() {
        ApiService.shared.searchGameName(name: gameName.replacingOccurrences(of: " ", with: "_")) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let games):
                        self.searchResult = games
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
        }
    }
    
}
