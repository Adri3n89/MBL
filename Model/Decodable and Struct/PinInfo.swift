//
//  PinInfo.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 09/12/2021.
//

import Foundation
import CoreLocation

struct PinInfo: Identifiable {
    var id = UUID()
    var name : String
    var lastName: String
    var userID: String
    var coordinates: CLLocationCoordinate2D
}
