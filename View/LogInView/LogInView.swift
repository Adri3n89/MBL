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
            Spacer()
            TFView(email: $viewModel.email, password: $viewModel.password)
            Spacer()
            Button("Log In") {
                print(viewModel.email)
                viewModel.signIn()
            }.fullScreenCover(isPresented: $viewModel.isPresented) {
                CustomTabView()
            }
            Spacer()
            BottomLogInView()
        }.alert(viewModel.error, isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) { }
        }
        .onAppear {
            AuthRepository.shared.logOut()
        }
        .background(Image("background")
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
        )
        .foregroundColor(.white)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
