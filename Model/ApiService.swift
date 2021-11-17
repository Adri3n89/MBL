//
//  ApiService.swift
//  MGL
//
//  Created by Adrien PEREA on 02/11/2021.
//

import Foundation

class ApiService: NSObject {
    
    static let shared = ApiService()

    // MARK: - Methods
    func getHotGame(_ urlString: String = Constantes.top50URL, _ session: URLSession = .shared, completed: @escaping (Result<[GameData], NetworkError>) -> Void) {
        var top: [GameData] = []
        guard let url = URL(string: urlString)?.absoluteURL else {
            completed(.failure(.badURL))
            return
        }
        session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let response = response as? HTTPURLResponse else {
                    completed(.failure(.badResponse))
                    return
                }
                do {
                    if response.statusCode == 200 {
                        if let data = data {
                            let apiResponse = try JSONDecoder().decode(Game.self, from: data)
                            for item in apiResponse.items.item {
                                let game = GameData(name: item.name.value, year: item.yearpublished?.value ?? "?", id: item.id, rank: item.rank, image: item.thumbnail.value)
                                top.append(game)
                                if top.count == 50 {
                                    completed(.success(top))
                                }
                            }
                        } else {
                            completed(.failure(.noData))
                        }
                    }
                } catch {
                    completed(.failure(.undecodableData))
                }
            }
        }.resume()
    }

    func getGameByID(id: String, _ session: URLSession = .shared, completed: @escaping (Result<ItemInfo, NetworkError>) -> Void) {
        let urlString = "https://api.factmaven.com/xml-to-json/?xml=https://api.geekdo.com/xmlapi2/thing?id=\(id)"
        guard let url = URL(string: urlString)?.absoluteURL else {
            completed(.failure(.badURL))
            return
        }
        session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let response = response as? HTTPURLResponse else {
                    completed(.failure(.badResponse))
                    return
                }
                do {
                    if response.statusCode == 200 {
                        if let data = data {
                            let apiResponse = try JSONDecoder().decode(ItemInfos.self, from: data)
                            completed(.success(apiResponse.items.item))
                        } else {
                            completed(.failure(.noData))
                        }
                    }
                } catch {
                    completed(.failure(.undecodableData))
                }
            }
        }.resume()
    }

    func getLibrary(libraryID: [String], _ session: URLSession = .shared, completed: @escaping (Result<[GameData], NetworkError>) -> Void) {
        var favoriteGames: [GameData] = []
        for favorite in libraryID {
            let urlString = "https://api.factmaven.com/xml-to-json/?xml=https://api.geekdo.com/xmlapi2/thing?id=\(favorite)"
            guard let url = URL(string: urlString)?.absoluteURL else {
                completed(.failure(.badURL))
                return
            }
            session.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    guard let response = response as? HTTPURLResponse else {
                        completed(.failure(.badResponse))
                        return
                    }
                    do {
                        if response.statusCode == 200 {
                            if let data = data {
                                let apiResponse = try JSONDecoder().decode(ItemInfos.self, from: data)
                                let item = apiResponse.items.item
                                let game = GameData(name: "", year: item.yearpublished.value, id: item.id, rank: "", image: item.image)
                                favoriteGames.append(game)
                                if libraryID.count == favoriteGames.count {
                                    completed(.success(favoriteGames))
                                }
                            } else {
                                completed(.failure(.noData))
                            }
                        }
                    } catch {
                        completed(.failure(.undecodableData))
                    }
                }
            }.resume()
        }
    }

    func getWish(wishID: [String], _ session: URLSession = .shared, completed: @escaping (Result<[GameData], NetworkError>) -> Void) {
        var wishGames: [GameData] = []
        for wish in wishID {
            let urlString = "https://api.factmaven.com/xml-to-json/?xml=https://api.geekdo.com/xmlapi2/thing?id=\(wish)"
            guard let url = URL(string: urlString)?.absoluteURL else {
                completed(.failure(.badURL))
                return
            }
            session.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    guard let response = response as? HTTPURLResponse else {
                        completed(.failure(.badResponse))
                        return
                    }
                    do {
                        if response.statusCode == 200 {
                            if let data = data {
                                let apiResponse = try JSONDecoder().decode(ItemInfos.self, from: data)
                                let item = apiResponse.items.item
                                let game = GameData(name: "", year: item.yearpublished.value, id: item.id, rank: "", image: item.image)
                                wishGames.append(game)
                                if wishID.count == wishGames.count {
                                    completed(.success(wishGames))
                                }
                            } else {
                                completed(.failure(.noData))
                            }
                        }
                    } catch {
                        completed(.failure(.undecodableData))
                    }
                }
            }.resume()
        }
    }

    func searchGameName(name: String, _ session: URLSession = .shared, completed: @escaping (Result<[ItemResult], NetworkError>) -> Void) {
        let urlString = "https://api.factmaven.com/xml-to-json/?xml=https://api.geekdo.com/xmlapi2/search?query=\(name)&type=boardgame,boardgameaccessory,boardgameexpansion"
        guard let url = URL(string: urlString)?.absoluteURL else {
            completed(.failure(.badURL))
            return
        }
        session.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completed(.failure(.badResponse))
                return
            }
            do {
                if response.statusCode == 200 {
                    if let data = data {
                        let apiResponse = try JSONDecoder().decode(SearchResult.self, from: data)
                        completed(.success(apiResponse.items.item))
                    } else {
                        completed(.failure(.noData))
                    }
                }
            } catch {
                completed(.failure(.undecodableData))
            }
        }.resume()
    }


}
