//
//  LogInView.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI
import FirebaseAuth

struct LogInView: View {
    
    @StateObject var viewModel = LogInViewModel()
    
    var body: some View {
        VStack {
            HeaderView()
                .foregroundColor(.white)
            Spacer()
            TFView(email: $viewModel.email, password: $viewModel.password)
                .foregroundColor(.white)
            Button(Constantes.logIn) {
                viewModel.signIn()
            }.fullScreenCover(isPresented: $viewModel.isPresented) {
                CustomTabView()
            }
                .padding(10)
                .background(.gray)
                .cornerRadius(10)
                .padding(.top, 30)
                .tint(.black)
            Spacer()
            BottomLogInView()
        }.alert(viewModel.error, isPresented: $viewModel.showError) {
            Button(Constantes.ok, role: .cancel) { }
        }
        .background(Image(Constantes.background)
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
        )
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
