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
    
    // send email to user to reset password
    func getNewPassword() {
        AuthRepository.shared.forgotPassword(email: email) { message in
            self.message = message
            self.showMessage.toggle()
        }
    }
    
}
