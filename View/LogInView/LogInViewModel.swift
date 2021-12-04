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
    
    func signIn() {
        AuthRepository.shared.signIn(email: email, password: password) { result in
            switch result {
                case .success(_):
                    self.isPresented = true
                case .failure(let error):
                    self.error = error.localizedDescription
                    self.showError = true
            }
        }
    }

}
