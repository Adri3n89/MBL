//
//  ItemInfos.swift
//  MGL
//
//  Created by Adrien PEREA on 02/11/2021.
//

import Foundation

// MARK: - IntemInfos
struct ItemInfos: Codable {
    let items: ItemsInfo
}

// MARK: - ItemsInfo
struct ItemsInfo: Codable {
    let termsofuse: String
    let item: ItemInfo
}

// MARK: - ItemInfo
struct ItemInfo: Codable {
    let type, id: String
    let thumbnail, image: String
    let itemDescription: String
    let yearpublished, minplayers, maxplayers: Maxplayers
    let playingtime, minplaytime, maxplaytime: Maxplayers


    enum CodingKeys: String, CodingKey {
        case type, id, thumbnail, image
        case itemDescription = "description"
        case yearpublished, minplayers, maxplayers, playingtime, minplaytime, maxplaytime
    }
}

// MARK: - Maxplayers
struct Maxplayers: Codable {
    let value: String
}
