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
    var apiService = ApiService()
    var cancellable = Set<AnyCancellable>()
    
    func searchGame() {
        searchResult = []
        // convert the caracteres to the good format for the api request
        apiService.searchGameName(name: gameName.convertForSearch())
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
