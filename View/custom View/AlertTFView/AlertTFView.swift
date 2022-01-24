//
//  AlertTFView.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 13/12/2021.
//

import SwiftUI

struct AlertTFView: View {
    
    var placeholder: String
    var buttonText: String
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = AlertTFViewModel()

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
            TextField(placeholder, text: $viewModel.text)
                .textFieldStyle(.roundedBorder)
                .frame(height: 50)
                .opacity(0.8)
                .cornerRadius(15)
                .padding([.trailing, .leading, .bottom], 20)
            Button {
                viewModel.changeValue(key: placeholder, value: viewModel.text)
            } label: {
                Text(buttonText)
                    .foregroundColor(.white)
            }.alert(viewModel.message, isPresented: $viewModel.showAlert, actions: {
                Button(role: .cancel) {
                    
                } label: {
                    Text("OK")
                }

            })
            .frame(height: 50)
            .padding([.leading, .trailing], 10)
            .background(.gray.opacity(0.8))
            .cornerRadius(15)
            .tint(.black)
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(30)
        .padding(50)
    }
}


struct AlertTFView_Previews: PreviewProvider {
    static var previews: some View {
        AlertTFView(placeholder: "Change your name", buttonText: "Update profil")
    }
}
