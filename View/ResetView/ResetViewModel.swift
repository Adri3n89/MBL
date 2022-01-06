//
//  ResetViewModel.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 29/11/2021.
//

import Foundation

final class ResetViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var message = ""
    @Published var showMessage = false
    var authRepo: AuthRepositoryProvider = AuthRepository()
    
    // send email to user to reset password
    func getNewPassword() {
        authRepo.forgotPassword(email: email) { message in
            self.message = message
            self.showMessage.toggle()
        }
    }
    
}
