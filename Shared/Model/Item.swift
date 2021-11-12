//
//  Item.swift
//  MGL
//
//  Created by Adrien PEREA on 02/11/2021.
//

import Foundation

// MARK: - Game
struct Game: Codable {
    let items: Items
}

// MARK: - Items
struct Items: Codable {
    let termsofuse: String
    let item: [Item]
}

// MARK: - Item
struct Item: Codable {
    let id, rank: String
    let thumbnail, name: Name
    let yearpublished: Name?
}

// MARK: - Name
struct Name: Codable {
    let value: String
}

struct GameData {
    let name: String
    let year: String?
    let id: String
    let rank: String
    let image: String
}
