//
//  ApiService.swift
//  MGL
//
//  Created by Adrien PEREA on 02/11/2021.
//

import Foundation

final class ApiService {

    // MARK: - Private Variables

    private var task: URLSessionTask?
    private var hotGameSession: URLSession

    // MARK: - Init

    init(hotGameSession: URLSession = URLSession(configuration: .default)) {
        self.hotGameSession = hotGameSession
    }

    // MARK: - Methods

    func getHotGame(callback: @escaping (Bool, [GameData]?) -> Void) {
        let urlString = "https://api.factmaven.com/xml-to-json/?xml=https://api.geekdo.com/xmlapi2/hot?type=boardgame"
        var gameArray: [GameData] = []
        if let url = URL(string: urlString) {
            task?.cancel()
            task = hotGameSession.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        callback(false, nil)
                        return
                    }
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        callback(false, nil)
                        return
                    }
                    guard let decodedResponse = try? JSONDecoder().decode(Game.self, from: data) else {
                        callback(false, nil)
                        return
                    }
                    for item in decodedResponse.items.item {
                        let game = GameData(name: item.name.value, year: item.yearpublished?.value ?? "?", id: item.id, rank: item.rank, image: item.thumbnail.value)
                            gameArray.append(game)
                    }
                    callback(true, gameArray)
                }
            }
            task?.resume()
        }
    }
    
    func getGameByID(id: String, callback: @escaping (Bool, ItemInfos?) -> Void) {
        let urlString = "https://api.factmaven.com/xml-to-json/?xml=https://api.geekdo.com/xmlapi2/thing?id=\(id)"
        if let url = URL(string: urlString) {
            task?.cancel()
            task = hotGameSession.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        callback(false, nil)
                        return
                    }
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        callback(false, nil)
                        return
                    }
                    guard let decodedResponse = try? JSONDecoder().decode(ItemInfos.self, from: data) else {
                        callback(false, nil)
                        return
                    }
                    callback(true, decodedResponse)
                    print(decodedResponse)
                }
            }
            task?.resume()
        }
    }
    
    func searchGameName(name: String, callback: @escaping (Bool, SearchResult?) -> Void) {
        let urlString = "https://api.factmaven.com/xml-to-json/?xml=https://api.geekdo.com/xmlapi2/search?query=\(name)&type=boardgame,boardgameaccessory,boardgameexpansion"
        if let url = URL(string: urlString) {
            task?.cancel()
            task = hotGameSession.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        callback(false, nil)
                        return
                    }
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        callback(false, nil)
                        return
                    }
                    guard let decodedResponse = try? JSONDecoder().decode(SearchResult.self, from: data) else {
                        callback(false, nil)
                        return
                    }
                    callback(true, decodedResponse)
                    print(decodedResponse)
                }
            }
            task?.resume()
        }
    }
    

}
