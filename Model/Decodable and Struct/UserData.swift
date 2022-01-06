//
//  UserData.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 18/11/2021.
//

import Foundation
import CoreLocation
import SwiftUI

struct UserData: Identifiable, Equatable {
    static func == (lhs: UserData, rhs: UserData) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = UUID()
    var name: String
    var lastName: String
    var userID: String
    var city: String
    var wish: [String] = []
    var library: [String] = []
    var coordinates = CLLocationCoordinate2D()
    var picture: String
    var refPic: String
}
