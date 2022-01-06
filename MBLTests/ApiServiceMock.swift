//
//  ApiServiceMock.swift
//  ApiServiceTest
//
//  Created by Adrien PEREA on 01/01/2022.
//

import Foundation
import Combine
@testable import MBL

struct ApiServiceMock: APIServiceProvider {
    
    var resultHotGame: Result<[GameData], NetworkError>?
    var resultGetGames: Result<GameData, NetworkError>?
    var resultSearchGame: Result<[ItemResult], NetworkError>?
    
    func getHotGame(_ urlString: String) -> AnyPublisher<[GameData], NetworkError> {
        resultHotGame!.publisher
            .eraseToAnyPublisher()
    }
    
    func getGames(gameID: String) -> AnyPublisher<GameData, NetworkError> {
        resultGetGames!.publisher
            .eraseToAnyPublisher()
    }
    
    func searchGameName(name: String) -> AnyPublisher<[ItemResult], NetworkError> {
        resultSearchGame!.publisher
            .eraseToAnyPublisher()
    }
    
    
}
