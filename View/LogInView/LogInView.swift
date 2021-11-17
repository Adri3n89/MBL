//
//  LogInView.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI

struct LogInView: View {
    
    @StateObject var viewModel = LogInViewModel()
    
    var body: some View {
        VStack {
            HeaderView()
            Spacer()
            Text("Please enter your account informations")
                .padding([.bottom], 20)
            TFView(email: $viewModel.email, password: $viewModel.password)
            Spacer()
            Button("Log In") {
                viewModel.signIn()
            }.fullScreenCover(isPresented: $viewModel.isPresented) {
                CustomTabView()
            }
            Spacer()
            BottomLogInView()
        }.alert(viewModel.error, isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) { }
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
