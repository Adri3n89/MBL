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
    var message = ""
    var userRepo: UserRepositoryProvider = UserRepository()
    
    func changeValue(key: String, value: String) {
        if key == Constantes.city.dropLast() {
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(value) { placemarks, error in
                guard (placemarks?.first) != nil else {
                    self.message = Constantes.errorAdress
                    self.showAlert.toggle()
                    return
                }
                self.userRepo.updateProfil(key: key, value: value)
            }
        } else {
            guard value.count >= 1 else {
                self.message = Constantes.oneLetter
                self.showAlert.toggle()
                return }
            userRepo.updateProfil(key: key, value: value)
        }
    }
}
