//
//  SignUp.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = SignUpViewModel()
    
    var body: some View {
        VStack {
            HeaderView().foregroundColor(.white)
            Spacer()
            TFSignUpView(email: $viewModel.email, password: $viewModel.password, name: $viewModel.name, lastName: $viewModel.lastName, city: $viewModel.city)
                .foregroundColor(.white)
            Spacer()
            Button("Create Account") {
                viewModel.signUp()
            }
            .fullScreenCover(isPresented: $viewModel.isCreated) {
                CustomTabView()
            }
            .tint(.white)
            Spacer()
            VStack {
                Text("Already have an account ?")
                    .foregroundColor(.white)
                Button("Sign In") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding([.bottom], 20)
                .tint(.white)
            }
        }.alert(viewModel.error, isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) { }
        }
        .background(Image("background")
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
        )
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
