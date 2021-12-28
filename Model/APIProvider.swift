//
//  APIProvider.swift
//  MBL (iOS)
//
//  Created by Adrien PEREA on 27/12/2021.
//

import Foundation
import Combine

protocol APIProvider {
    func fetch(url: URL) -> AnyPublisher<Data, NetworkError>
}
