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
struct ItemInfo: Codable, Identifiable {
    let type, id: String
    let thumbnail, image: String?
    var itemDescription: String
    let yearpublished : Maxplayers?
    let minplayers, maxplayers: Maxplayers
    let playingtime, minplaytime, maxplaytime, minage: Maxplayers

   enum CodingKeys: String, CodingKey {
       case type, id, thumbnail, image
       case itemDescription = "description"
       case yearpublished, minplayers, maxplayers, playingtime, minplaytime, maxplaytime, minage
   }
}

// MARK: - Maxplayers
struct Maxplayers: Codable {
    let value: String
}

//struct GameName: Codable {
//    let type, sortindex, value: String
//}
