//
//  APIMockResources.swift
//  ApiServiceTest
//
//  Created by Adrien PEREA on 27/12/2021.
//

import Foundation
import Combine
import SwiftUI
@testable import MBL

struct APIMockResources: APIProvider {
   
    var result: Result<Data, NetworkError>
    
    func fetch(url: URL) -> AnyPublisher<Data, NetworkError> {
        result.publisher
            .eraseToAnyPublisher()
    }
    
    
    
}
