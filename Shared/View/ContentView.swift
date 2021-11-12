//
//  ContentView.swift
//  Shared
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                let _ = print("error")
                return
            }
            // SUCCESS
            let _ = print("success")
        }
    }
    
    func signUp(email: String, password: String, name: String, lastName: String, city: String) {
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                let _ = print("error")
                return
            }
            // SUCCESS
        }
    }
}

struct ContentView: View {
    
    var body: some View {
        LogInView(email: "", password: "")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
