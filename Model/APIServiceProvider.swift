//
//  APIServiceProvider.swift
//  ApiServiceTest
//
//  Created by Adrien PEREA on 01/01/2022.
//

import Foundation
import Combine

protocol APIServiceProvider {
    
    func getHotGame(_ urlString: String) -> AnyPublisher<[GameData],NetworkError>

    func getGames(gameID: String) -> AnyPublisher<GameData, NetworkError>

    func searchGameName(name: String) -> AnyPublisher<[ItemResult], NetworkError>
}
