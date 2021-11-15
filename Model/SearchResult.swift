//
//  SearchResult.swift
//  MGL
//
//  Created by Adrien PEREA on 02/11/2021.
//

import Foundation

// MARK: - Search
struct SearchResult: Codable {
    let items: ItemsResult
}

// MARK: - Items
struct ItemsResult: Codable {
    let total: String
    let termsofuse: String
    let item: [ItemResult]
}

// MARK: - Item
struct ItemResult: Codable, Identifiable {
    let id: String
    let type: ItemType
    let name: NameResult
    let yearpublished: Yearpublished?
}

// MARK: - Name
struct NameResult: Codable {
    let type: NameType
    let value: String
}

enum NameType: String, Codable {
    case alternate = "alternate"
    case primary = "primary"
}

enum ItemType: String, Codable {
    case boardgame = "boardgame"
    case boardgameexpansion = "boardgameexpansion"
    case rpg = "rpg"
    case rpgissue = "rpgissue"
    case rpgitem = "rpgitem"
    case videogame = "videogame"
    case rpgperiodical = "rpgperiodical"
    case boardgameperson = "boardgameperson"
    case rpgperson = "rpgperson"
    case boardgamecompany = "boardgamecompany"
    case rpgcompany = "rpgcompany"
    case videogamecompany = "videogamecompany"
}

// MARK: - Yearpublished
struct Yearpublished: Codable {
    let value: String
}
