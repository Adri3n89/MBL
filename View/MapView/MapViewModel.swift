//
//  MapViewModel.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 18/11/2021.
//

import Foundation
import MapKit
import CoreLocation

final class MapViewModel: ObservableObject {
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.34, longitude: 3.06),
        span: MKCoordinateSpan(latitudeDelta: 0.09, longitudeDelta: 0.09)
    )
    @Published var allUsers: [UserData] = [UserData(name: "Toto", lastName: "Uno", city: "89340 VILLENEUVE LA GUYARD"),
                                           UserData(name: "Tata", lastName: "Dos", city: "77130 MAROLLES-SUR-SEINE"),
                                           UserData(name: "Tutu", lastName: "Tres", city: "77130 MISY-SUR-YONNE"),
                                           UserData(name: "Titi", lastName: "Quatro", city: "89100 SENS")]
    
    @Published var allAdress = ["89340 VILLENEUVE LA GUYARD", "77130 MAROLLES-SUR-SEINE", "77130 MISY-SUR-YONNE", "89100 SENS"]
    @Published var allCoordinates: [Coord] = []
    
    func geoCode(addresses: [String], results: [CLPlacemark] = [], completion: @escaping ([CLPlacemark]) -> Void ) {
        guard let address = addresses.first else {
            completion(results)
            return
        }

        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { placemarks, error in

            var updatedResults = results

            if let placemark = placemarks?.first {
                updatedResults.append(placemark)
            }

            let remainingAddresses = Array(addresses[1..<addresses.count])

            self.geoCode(addresses: remainingAddresses, results: updatedResults, completion: completion)
        }
    }
    
    
}

struct Coord: Identifiable {
    let id = UUID()
    let coordinates: CLLocationCoordinate2D
}
