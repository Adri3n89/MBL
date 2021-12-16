//
//  SignUp.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = SignUpViewModel()
    
    var body: some View {
        ScrollView {
            HeaderView().foregroundColor(.white)
            Spacer()
            TFSignUpView(email: $viewModel.email, password: $viewModel.password, name: $viewModel.name, lastName: $viewModel.lastName, city: $viewModel.city)
                .foregroundColor(.white)
            Button(Constantes.createAccount) {
                viewModel.signUp()
            }
            .fullScreenCover(isPresented: $viewModel.isCreated) {
                CustomTabView()
            }
                .tint(.white)
                .padding(10)
                .background(.gray)
                .cornerRadius(10)
                .padding(.top, 30)
            Spacer()
            VStack {
                Text(Constantes.alreadyAccount)
                    .foregroundColor(.white)
                Button(Constantes.signIn) {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding([.bottom], 20)
                .tint(.white)
            }
        }.alert(viewModel.error, isPresented: $viewModel.showError) {
            Button(Constantes.ok, role: .cancel) { }
        }
        .background(BackgroundView())
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
