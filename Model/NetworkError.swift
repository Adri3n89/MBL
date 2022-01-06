//
//  NetworkError.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 16/11/2021.
//

import Foundation

enum NetworkError: Error {
    case noData
    case badResponse
    case undecodableData
    case badURL
    case noResult
    
    static func convert(error: Error) -> NetworkError {
        switch error {
        case is URLError:
            return .badURL
        case is NetworkError:
            return error as! NetworkError
        default:
            return .undecodableData
        }
    }
    
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noData: return NSLocalizedString("No Data, please check Internet", comment: "Network Error")
        case .badResponse: return NSLocalizedString("Bad response from API.", comment: "Network Error")
        case .undecodableData: return NSLocalizedString("Undecodable Datas, try again", comment: "Network Error")
        case .badURL: return NSLocalizedString("Bad URL.", comment: "Network Error")
        case .noResult: return NSLocalizedString("No Result", comment: "Network Error")
        }
    }
}
