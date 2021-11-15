//
//  SignUp.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var auth: AuthRepository
    @State var isCreated = false
    @State var email: String = ""
    @State var password: String = ""
    @State var name: String = ""
    @State var lastName: String = ""
    @State var city: String = ""
    
    var body: some View {
        VStack {
            HeaderView()
            Spacer()
            TFSignUpView(email: $email, password: $password, name: $name, lastName: $lastName, city: $city)
            Spacer()
            Button("Create Account") {
                auth.signUp(email: email, password: password, name: name, lastName: lastName, city: city)
                self.isCreated.toggle()
            }.fullScreenCover(isPresented: $isCreated) {
                CustomTabView()
            }
            Spacer()
            VStack {
                Text("Already have an account ?")
                Button("Sign In") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding([.bottom], 20)
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
