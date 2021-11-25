//
//  SignUpViewModel.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 17/11/2021.
//

import Foundation
import CoreLocation

final class SignUpViewModel: ObservableObject {
    
    @Published var isCreated = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var lastName: String = ""
    @Published var city: String = ""
    @Published var showError = false
    @Published var error: String = ""
    
    func signUp() {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(city) { placemarks, error in
            if (placemarks?.first) != nil {
                if self.name.count >= 1 && self.lastName.count >= 1 {
                    AuthRepository.shared.signUp(email: self.email, password: self.password, name: self.name, lastName: self.lastName, city: self.city) { result in
                        switch result {
                            case .success(_):
                                self.isCreated = true
                                AuthRepository.shared.signIn(email: self.email, password: self.password) { result in
                                    switch result {
                                        case .success(_):
                                            AuthRepository.shared.createUserInfo(email: self.email, name: self.name, lastName: self.lastName, city: self.city)
                                        case .failure(let error):
                                            self.error = error.localizedDescription
                                            self.showError = true
                                    }
                                }
                            case .failure(let error):
                                self.error = error.localizedDescription
                                self.showError = true
                        }
                    }
                } else {
                    self.error = Constantes.errorName
                    self.showError = true
                }
            } else {
                self.error = Constantes.errorAdress
                self.showError = true
            }
        }
    }
}
