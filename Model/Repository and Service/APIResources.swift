//
//  APIResources.swift
//  MBL (iOS)
//
//  Created by Adrien PEREA on 27/12/2021.
//

import Foundation
import Combine

struct APIResources: APIProvider {
    
    var session: URLSession = URLSession.shared
    
    func fetch(url: URL) -> AnyPublisher<Data, NetworkError> {
        return session.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                if let response = response as? HTTPURLResponse,
                   !(200...299).contains(response.statusCode) {
                    throw NetworkError.badResponse
                } else {
                    return data
                }
            }
            .mapError({ error in
                NetworkError.convert(error: error)
            })
            .eraseToAnyPublisher()
    }
    
}
