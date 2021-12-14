//
//  ApiService.swift
//  MGL
//
//  Created by Adrien PEREA on 02/11/2021.
//

import Foundation

final class ApiService: ObservableObject {
    
    static let shared = ApiService()

    // MARK: - Methods
    func getHotGame(_ urlString: String = Constantes.urlTop50, _ session: URLSession = .shared, completed: @escaping (Result<[GameData], NetworkError>) -> Void) {
        //reccupération du top50 des jeux du moment
        var top: [GameData] = []
        guard let url = URL(string: urlString)?.absoluteURL else {
            completed(.failure(.badURL))
            return
        }
        session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completed(.failure(.noData))
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completed(.failure(.badResponse))
                    return
                }
                do {
                    let apiResponse = try JSONDecoder().decode(Game.self, from: data)
                    for item in apiResponse.items.item {
                        let game = GameData(name: item.name.value, year: item.yearpublished?.value ?? "?", id: item.id, rank: item.rank, image: (item.thumbnail.value == "") ? Constantes.defaultGamePicture : item.thumbnail.value)
                        top.append(game)
                        if top.count == 50 {
                            completed(.success(top))
                        }
                    }
                } catch {
                    completed(.failure(.undecodableData))
                }
            }
        }.resume()
    }

    func getGameByID(id: String, _ session: URLSession = .shared, completed: @escaping (Result<ItemInfo, NetworkError>) -> Void) {
        let urlString = Constantes.urlByID + id
        guard let url = URL(string: urlString)?.absoluteURL else {
            completed(.failure(.badURL))
            return
        }
        session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completed(.failure(.noData))
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completed(.failure(.badResponse))
                    return
                }
                do {
                    let apiResponse = try JSONDecoder().decode(ItemInfos.self, from: data)
                    var game = apiResponse.items.item
                    game.itemDescription = apiResponse.items.item.itemDescription.decodingHTMLEntities()
                    completed(.success(game))
                } catch {
                    completed(.failure(.undecodableData))
                }
            }
        }.resume()
    }

    func getGames(arrayID: [String], _ session: URLSession = .shared, completed: @escaping (Result<[GameData], NetworkError>) -> Void) {
        //reccupération des informations pour l'ensemble des ID de jeu de la library de l'utilisateur
        var games: [GameData] = []
        for id in arrayID {
            let urlString = Constantes.urlByID + id
            guard let url = URL(string: urlString)?.absoluteURL else {
                completed(.failure(.badURL))
                return
            }
            session.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        completed(.failure(.noData))
                        return
                    }
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        completed(.failure(.badResponse))
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(ItemInfos.self, from: data)
                        let item = apiResponse.items.item
                        let game = GameData(name: "", year: item.yearpublished?.value ?? "?", id: item.id, rank: "", image: item.image ?? Constantes.defaultGamePicture)
                        games.append(game)
                        if arrayID.count == games.count {
                            completed(.success(games))
                        }
                    } catch {
                        completed(.failure(.undecodableData))
                    }
                }
            }.resume()
        }
    }

    func searchGameName(name: String, _ session: URLSession = .shared, completed: @escaping (Result<[ItemResult], NetworkError>) -> Void) {
        //retourne la liste de jeu correspondant à la reherche faite par l'utilisateur
        let urlString = Constantes.urlByName(name: name)
        guard let url = URL(string: urlString)?.absoluteURL else {
            completed(.failure(.badURL))
            return
        }
        session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completed(.failure(.noData))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.badResponse))
                return
            }
            do {
                let apiResponse = try JSONDecoder().decode(SearchResult.self, from: data)
                guard let items = apiResponse.items.item else {
                    completed(.failure(.noResult))
                    return
                }
                completed(.success(items))
            } catch {
                completed(.failure(.undecodableData))
            }
        }.resume()
    }


}
