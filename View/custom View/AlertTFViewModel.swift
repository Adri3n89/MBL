//
//  AlertTFViewModel.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 13/12/2021.
//

import Foundation
import MapKit

final class AlertTFViewModel: ObservableObject {
    
    @Published var text = ""
    @Published var showAlert = false
    var userRepo: UserRepositoryProvider = UserRepository()
    let message = "Address not find, please try again"
    
    func changeValue(key: String, value: String) {
        if key == "City" {
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(value) { placemarks, error in
                guard (placemarks?.first) != nil else {
                    self.showAlert.toggle()
                    return
                }
                self.userRepo.updateProfil(key: key, value: value)
            }
        } else {
            userRepo.updateProfil(key: key, value: value)
        }
    }
}
