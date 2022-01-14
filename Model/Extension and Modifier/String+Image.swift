//
//  String+Image.swift
//  MBL (iOS)
//
//  Created by Adrien PEREA on 14/01/2022.
//

import Foundation

extension String {
    
    func imageName() -> String {
        let letters = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890"
        return String((0 ..< 24).map { _ in letters.randomElement()! })
    }
}
