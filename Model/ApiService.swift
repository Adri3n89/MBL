//
//  ApiService.swift
//  MGL
//
//  Created by Adrien PEREA on 02/11/2021.
//

import Foundation
import Alamofire
import SwiftUI

class ApiService: ObservableObject {
    
    // MARK: Variable
    var sessionManager: Session = {
           let configuration = URLSessionConfiguration.af.default
           return Session(configuration: configuration)
       }()
    
    @Published var top50: [GameData] = []
    @Published var gameInfo: ItemInfo?
    @Published var searchResult: [ItemResult] = []
    @Published var favorite: [GameData] = []
    @Published var wish: [GameData] = []
    let favoriteID: [String] = ["1345","2930"]
    let wishID: [String] = ["3245", "2134", "9230"]

    // MARK: - Methods
    func getHotGame() {
        top50 = []
        let urlString = "https://api.factmaven.com/xml-to-json/?xml=https://api.geekdo.com/xmlapi2/hot?type=boardgame"
        if let url = URL(string: urlString) {
            let request = sessionManager.request(url)
            request.responseDecodable(of: Game.self) { response in
                if let items = response.value?.items.item {
                    for item in items {
                        let game = GameData(name: item.name.value, year: item.yearpublished?.value ?? "?", id: item.id, rank: item.rank, image: item.thumbnail.value)
                        self.top50.append(game)
                    }
                }
            }
        }
    }
    
    func getGameByID(id: String) {
        gameInfo = nil
        let urlString = "https://api.factmaven.com/xml-to-json/?xml=https://api.geekdo.com/xmlapi2/thing?id=\(id)"
        if let url = URL(string: urlString) {
            let request = sessionManager.request(url)
            request.responseDecodable(of: ItemInfos.self) { response in
                if let item = response.value?.items.item {
                    self.gameInfo = item
                }
            }
        }
    }
    
    func getFavorite(favoritesID: [String]) {
        favorite = []
        for favorite in favoritesID {
            let urlString = "https://api.factmaven.com/xml-to-json/?xml=https://api.geekdo.com/xmlapi2/thing?id=\(favorite)"
            if let url = URL(string: urlString) {
                let request = sessionManager.request(url)
                request.responseDecodable(of: ItemInfos.self) { response in
                    if let item = response.value?.items.item {
                        let game = GameData(name: "", year: item.yearpublished.value, id: item.id, rank: "", image: item.image)
                        self.favorite.append(game)
                    }
                }
            }
        }
    }
    
    func getWish(wishID: [String]) {
        wish = []
        for wish in wishID {
            let urlString = "https://api.factmaven.com/xml-to-json/?xml=https://api.geekdo.com/xmlapi2/thing?id=\(wish)"
            if let url = URL(string: urlString) {
                let request = sessionManager.request(url)
                request.responseDecodable(of: ItemInfos.self) { response in
                    if let item = response.value?.items.item {
                        let game = GameData(name: "", year: item.yearpublished.value, id: item.id, rank: "", image: item.image)
                        self.wish.append(game)
                    }
                }
            }
        }
    }
    
    func searchGameName(name: String) {
        searchResult = []
        let urlString = "https://api.factmaven.com/xml-to-json/?xml=https://api.geekdo.com/xmlapi2/search?query=\(name)&type=boardgame,boardgameaccessory,boardgameexpansion"
        if let url = URL(string: urlString) {
            let request = sessionManager.request(url)
            request.responseDecodable(of: SearchResult.self) { response in
                if let result = response.value {
                    self.searchResult = result.items.item
                }
            }
        }
    }


}
