//
//  LogInViewModel.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 16/11/2021.
//

import Foundation

final class LogInViewModel: ObservableObject {
    
    @Published var isPresented = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var error: String = ""
    @Published var showError = false
    @Published var showReset = false
    @Published var resetEmail = ""
    var authRepo: AuthRepositoryProvider = AuthRepository()

    
    func signIn() {
        authRepo.signIn(email: email, password: password) { result in
            switch result {
                case .success(let bool):
                    self.isPresented = bool
                case .failure(let error):
                    self.error = error.localizedDescription
                    self.showError = true
            }
        }
    }

}
