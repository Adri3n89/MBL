//
//  ApiService.swift
//  MGL
//
//  Created by Adrien PEREA on 02/11/2021.
//

import Foundation
import Combine

final class ApiService {
       
    var apiResources : APIProvider
    
    init(apiResources: APIProvider = APIResources()) {
        self.apiResources = apiResources
    }

    // MARK: - Methods
    func getHotGame(_ urlString: String = Constantes.urlTop50) -> AnyPublisher<[GameData],NetworkError> {
        //reccupération du top50 des jeux du moment
        guard let url = URL(string: urlString)?.absoluteURL else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        return apiResources.fetch(url: url)
            .decode(type: Game.self, decoder: JSONDecoder())
            .tryMap{ top50 in
                self.transformTop50ToGameData(top50: top50)
            }
            .mapError{ error in
                NetworkError.convert(error: error)
            }
            .eraseToAnyPublisher()
    }

    func getGames(gameID: String) -> AnyPublisher<GameData, NetworkError> {
        //reccupération des informations pour l'ensemble des ID de jeu de la library de l'utilisateur
        let urlString = Constantes.urlByID + gameID
        guard let url = URL(string: urlString)?.absoluteURL else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        return apiResources.fetch(url: url)
            .decode(type: ItemInfos.self, decoder: JSONDecoder())
            .tryMap { itemInfos in
                self.transformItemInfosToGameData(itemInfos: itemInfos)
            }
            .mapError{ error in
                NetworkError.convert(error: error)
            }
            .eraseToAnyPublisher()
        }

    func searchGameName(name: String) -> AnyPublisher<[ItemResult], NetworkError> {
        //retourne la liste de jeu correspondant à la reherche faite par l'utilisateur
        let urlString = Constantes.urlByName(name: name)
        guard let url = URL(string: urlString)?.absoluteURL else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        return apiResources.fetch(url: url)
            .decode(type: SearchResult.self, decoder: JSONDecoder())
            .tryMap { result in
                guard let games = result.items.item else { return [] }
                 return games
            }
            .mapError{ error in
                NetworkError.convert(error: error)
            }
            .eraseToAnyPublisher()
    }
    
    private func transformTop50ToGameData(top50: Game) -> [GameData] {
        var games : [GameData] = []
        for item in top50.items.item {
            let game = GameData(name: item.name.value, year: item.yearpublished?.value ?? "?", id: item.id, rank: item.rank, image: (item.thumbnail.value == "") ? Constantes.defaultGamePicture : item.thumbnail.value, description: "", minPlayer: "", maxPlayer: "", minTime: "", maxTime: "")
            games.append(game)
        }
        return games
    }
    
    private func transformItemInfosToGameData(itemInfos: ItemInfos) -> GameData {
        let item = itemInfos.items.item
        return GameData(name: item.name, year: item.yearpublished?.value ?? "?", id: item.id, rank: item.rank, image: item.image ?? Constantes.defaultGamePicture, description: item.itemDescription.decodingHTMLEntities(), minPlayer: item.minplayers.value, maxPlayer: item.maxplayers.value, minTime: item.minplaytime.value, maxTime: item.maxplaytime.value)
    }

}

