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
    
    // zone d'ouverture de la map/ à changer en fonction de l'utilisateur
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.34, longitude: 3.06),
        span: MKCoordinateSpan(latitudeDelta: 0.09, longitudeDelta: 0.09)
    )
    @Published var allUsers: [UserData] = []
    @Published var allCoordinates: [PinInfo] = []
    @Published var allAdresses: [String] = []
    @Published var showLibrary = false
    
    func getAllUsers() {
        // Réccupération de tout les utilisateurs de Firebase
        AuthRepository.shared.fetchAllUsers { usersInfo in
            self.allUsers = usersInfo
            self.getAllAdresses()
        }
    }
    
    func getAllAdresses() {
        // création d'un tableau avec les adresses de tout les utilisateurs
        var all = [String]()
        for user in allUsers {
            all.append(user.city)
        }
        allAdresses = all
        // geoCode de chaque adresse pour avoir les coordonnées et les ajouter au tableau AllCoordinates
        geoCode(addresses: allAdresses) { placemarks in
            for index in 0...placemarks.count-1 {
                if self.allUsers[index].userID != AuthRepository.shared.userID {
                self.allCoordinates.append(PinInfo(name: self.allUsers[index].name, lastName: self.allUsers[index].lastName,userID: self.allUsers[index].userID, coordinates: CLLocationCoordinate2D(latitude: (placemarks[index].location?.coordinate.latitude)! , longitude: (placemarks[index].location?.coordinate.longitude)!)))
                }
            }
        }
    }
    
    func geoCode(addresses: [String], results: [CLPlacemark] = [], completion: @escaping ([CLPlacemark]) -> Void ) {
        // fonction pour Geocoder un tableau de string car une boucle for ne marche pas a cause de l'asynchrone du geocode
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
