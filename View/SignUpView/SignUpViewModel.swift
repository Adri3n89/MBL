//
//  SignUpViewModel.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 17/11/2021.
//

import Foundation

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
        AuthRepository.shared.signUp(email: email, password: password, name: name, lastName: lastName, city: city) { result in
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
    }
}
