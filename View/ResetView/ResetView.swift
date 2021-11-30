//
//  ResetView.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 29/11/2021.
//

import SwiftUI

struct ResetView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = ResetViewModel()

    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: Constantes.xmark)
                }.padding()
            }
            TextField("", text: $viewModel.email)
                .placeholder(when: viewModel.email.isEmpty) {
                    Text(Constantes.emailTF).foregroundColor(.white)
            }
                .frame(height: 50)
                .background(.gray)
                .opacity(0.8)
                .cornerRadius(15)
                .padding([.trailing, .leading, .bottom], 30)
            Button(Constantes.resetPassword) {
                viewModel.getNewPassword()
            }.alert(viewModel.message, isPresented: $viewModel.showMessage) {
                Button(Constantes.ok, role: .cancel) { }
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(30)
    }
}

struct ResetView_Previews: PreviewProvider {
    static var previews: some View {
        ResetView()
            .previewLayout(.sizeThatFits)
    }
}