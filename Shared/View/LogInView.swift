//
//  LogInView.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI

struct LogInView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    @State var isPresented = false
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        VStack {
            HeaderView()
            Spacer()
            Text("Please enter your account informations")
                .padding([.bottom], 20)
            TFView(email: $email, password: $password)
            Spacer()
            Button("Log In") {
                viewModel.signIn(email: email, password: password)
                self.isPresented.toggle()
            }.fullScreenCover(isPresented: $isPresented) {
                CustomTabView()
            }
            Spacer()
            BottomLogInView()
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
