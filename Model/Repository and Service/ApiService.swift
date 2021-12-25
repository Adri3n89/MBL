//
//  ApiService.swift
//  MGL
//
//  Created by Adrien PEREA on 02/11/2021.
//

import Foundation
import Combine

final class ApiService: ObservableObject {
    
    static let shared = ApiService()

    // MARK: - Methods
    func getHotGame(_ urlString: String = Constantes.urlTop50, _ session: URLSession = .shared) -> AnyPublisher<[GameData],NetworkError> {
        //reccupération du top50 des jeux du moment
        guard let url = URL(string: urlString)?.absoluteURL else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: url)
            .tryMap{ data, response in
                return data
            }
            .mapError{ error in
                NetworkError.noData
            }
            .decode(type: Game.self, decoder: JSONDecoder())
            .mapError{ error in
                NetworkError.undecodableData
            }
            .tryMap{ top50 in
                self.transformTop50ToGameData(top50: top50)
            }
            .mapError{ error in
                NetworkError.noResult
            }
            .eraseToAnyPublisher()
    }

    func getGameByID(id: String, _ session: URLSession = .shared) -> AnyPublisher<ItemInfo,NetworkError> {
        let urlString = Constantes.urlByID + id
        guard let url = URL(string: urlString)?.absoluteURL else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: url)
            .tryMap { data, response in
                return data
            }
            .mapError{ error in
                NetworkError.noData
            }
            .decode(type: ItemInfos.self, decoder: JSONDecoder())
            .mapError { error in
                NetworkError.undecodableData
            }
            .tryMap { item in
                self.transformItemInfosToItemInfoAndDecodeString(item: item)
            }
            .mapError { error in
                NetworkError.noResult
            }
            .eraseToAnyPublisher()
    }

    func getGames(gameID: String, _ session: URLSession = .shared) -> AnyPublisher<GameData, NetworkError> {
        //reccupération des informations pour l'ensemble des ID de jeu de la library de l'utilisateur
        let urlString = Constantes.urlByID + gameID
        guard let url = URL(string: urlString)?.absoluteURL else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: url)
            .tryMap { data, response in
                return data
            }
            .mapError{ error in
                NetworkError.noData
            }
            .decode(type: ItemInfos.self, decoder: JSONDecoder())
            .mapError { error in
                NetworkError.undecodableData
            }
            .tryMap { itemInfos in
                self.transformItemInfosToGameData(itemInfos: itemInfos)
            }
            .mapError { error in
                NetworkError.noResult
            }
            .eraseToAnyPublisher()
        }

    func searchGameName(name: String, _ session: URLSession = .shared) -> AnyPublisher<[ItemResult], NetworkError> {
        //retourne la liste de jeu correspondant à la reherche faite par l'utilisateur
        let urlString = Constantes.urlByName(name: name)
        guard let url = URL(string: urlString)?.absoluteURL else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: url)
            .tryMap { data, response in
                return data
            }
            .mapError { error in
                NetworkError.noData
            }
            .decode(type: SearchResult.self, decoder: JSONDecoder())
            .mapError { error in
                NetworkError.undecodableData
            }
            .tryMap { result in
                 return result.items.item ?? []
            }
            .mapError { error in
                NetworkError.noResult
            }
            .eraseToAnyPublisher()
    }
    
    private func transformTop50ToGameData(top50: Game) -> [GameData] {
        var games : [GameData] = []
        for item in top50.items.item {
            let game = GameData(name: item.name.value, year: item.yearpublished?.value ?? "?", id: item.id, rank: item.rank, image: (item.thumbnail.value == "") ? Constantes.defaultGamePicture : item.thumbnail.value)
            games.append(game)
        }
        return games
    }
    
    private func transformItemInfosToItemInfoAndDecodeString(item: ItemInfos) -> ItemInfo {
        var finalItem = item.items.item
        finalItem.itemDescription = item.items.item.itemDescription.decodingHTMLEntities()
        return finalItem
    }
    
    private func transformItemInfosToGameData(itemInfos: ItemInfos) -> GameData {
        let item = itemInfos.items.item
        return GameData(name: "", year: item.yearpublished?.value ?? "?", id: item.id, rank: "", image: item.image ?? Constantes.defaultGamePicture)
    }

}
