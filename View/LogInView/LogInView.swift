//
//  LogInView.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI

struct LogInView: View {
    
    @ObservedObject var viewModel = LogInViewModel()
    
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
                .frame(height: 50)
                .padding([.leading, .trailing], 40)
                .background(.gray)
                .cornerRadius(15)
                .padding([.top, .bottom], 30)
                .tint(.black)
            Button(Constantes.forgotPassword) {
                viewModel.showReset.toggle()
            }.sheet(isPresented: $viewModel.showReset) { 
                ResetView()
                    .background(BackgroundClearView())
            }
            .padding(10)
            .frame(height: 50)
            .background(.gray)
            .cornerRadius(15)
            .tint(.black)
            Spacer()
            Spacer()
            BottomLogInView()
        }.alert(viewModel.error, isPresented: $viewModel.showError) {
            Button(Constantes.ok, role: .cancel) { }
        }
        .background(
            Image(Constantes.background)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
        )
        .onAppear {
            viewModel.isPresented = AuthRepository.shared.isSignIn()
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
