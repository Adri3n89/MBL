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
            TextField(Constantes.emailTF, text: $viewModel.email)
                .textFieldStyle(.roundedBorder)
                .frame(height: 50)
                .opacity(0.8)
                .cornerRadius(15)
                .padding([.trailing, .leading, .bottom], 20)
            Button(Constantes.resetPassword) {
                viewModel.getNewPassword()
            }.alert(viewModel.message, isPresented: $viewModel.showMessage) {
                Button(Constantes.ok, role: .cancel) { }
            }
            .frame(height: 50)
            .padding([.leading, .trailing], 10)
            .background(.gray)
            .cornerRadius(15)
            .tint(.black)
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(30)
        .padding(50)
    }
}

struct ResetView_Previews: PreviewProvider {
    static var previews: some View {
        ResetView()
            .previewLayout(.sizeThatFits)
    }
}
