//
//  UserData.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 18/11/2021.
//

import Foundation
import CoreLocation

struct UserData: Identifiable {
    var id = UUID()
    var name: String
    var lastName: String
    var city: String
    var wish: [String] = []
    var library: [String] = []
    var coordinates: CLLocationCoordinate2D?
}
