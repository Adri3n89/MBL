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
    
}
