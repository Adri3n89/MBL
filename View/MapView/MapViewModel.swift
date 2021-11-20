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
    @Published var allUsers: [UserData] = []
    @Published var allCoordinates: [PinInfo] = []
    @Published var allAdresses: [String] = []
    
    func getAllUsers() {
        AuthRepository.shared.fetchAllUsers { usersInfo in
            self.allUsers = usersInfo
            self.getAllAdresses()
        }
    }
    
    func getAllAdresses() {
        var all = [String]()
        for user in allUsers {
            all.append(user.city)
        }
        allAdresses = all
        geoCode(addresses: allAdresses) { placemarks in
            for index in 0...placemarks.count-1 {
                self.allCoordinates.append(PinInfo(name: self.allUsers[index].name, lastName: self.allUsers[index].lastName,userID: self.allUsers[index].userID, coordinates: CLLocationCoordinate2D(latitude: (placemarks[index].location?.coordinate.latitude)! , longitude: (placemarks[index].location?.coordinate.longitude)!)))
            }
        }
    }
    
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