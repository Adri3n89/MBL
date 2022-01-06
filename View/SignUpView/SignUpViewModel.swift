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
    var userRepo: UserRepositoryProvider = UserRepository()
    var authRepo: AuthRepositoryProvider = AuthRepository()
    
    func signUp() {
        // check if the adress if found with the geocoder to be sure the user can be find on the mapTab
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(city) { placemarks, error in
            guard (placemarks?.first) != nil else {
                self.error = Constantes.errorAdress
                self.showError = true
                return
            }
            guard self.name.count >= 1 && self.lastName.count >= 1 else {
                self.error = Constantes.errorName
                self.showError = true
                return
            }
            self.authRepo.signUp(email: self.email, password: self.password, name: self.name, lastName: self.lastName, city: self.city) { result in
                switch result {
                    case .success(let bool):
                        self.isCreated = bool
                        self.authRepo.signIn(email: self.email, password: self.password) { result in
                            switch result {
                                case .success(_):
                                self.userRepo.createUserInfo(email: self.email, name: self.name, lastName: self.lastName, city: self.city)
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
        }
    }
}
