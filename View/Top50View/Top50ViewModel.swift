//
//  Top50ViewModel.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 16/11/2021.
//

import Foundation
import SwiftUI

final class Top50ViewModel: ObservableObject {
    
    @Published var top50: [GameData] = []
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // fetch the TOP 50 games from the api in array
    func getTop50() {
        ApiService.shared.getHotGame { result in
            switch result {
                case .success(let top):
                    self.top50 = top
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
