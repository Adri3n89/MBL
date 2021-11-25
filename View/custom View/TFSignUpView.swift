//
//  FTSignUpView.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI

struct TFSignUpView: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var name: String
    @Binding var lastName: String
    @Binding var city: String
        
        var body: some View {
            VStack {
                TFView(email: $email, password: $password)
                HStack {
                    Text(Constantes.name)
                    Spacer()
                }
                .padding([.trailing, .leading], 30)
                TextField("", text: $name)
                    .placeholder(when: name.isEmpty) {
                        Text(Constantes.nameTF).foregroundColor(.black)
                }
                    .frame(height: 50)
                    .background(.secondary)
                    .cornerRadius(15)
                    .padding([.trailing, .leading], 30)
                HStack {
                    Text(Constantes.lastName)
                    Spacer()
                }
                .padding([.trailing, .leading], 30)
                TextField("", text: $lastName)
                    .placeholder(when: lastName.isEmpty) {
                        Text(Constantes.lastNameTF).foregroundColor(.black)
                }
                    .frame(height: 50)
                    .background(.secondary)
                    .cornerRadius(15)
                    .padding([.trailing, .leading], 30)
                HStack {
                    Text(Constantes.city)
                    Spacer()
                }
                .padding([.trailing, .leading], 30)
                TextField("", text: $city)
                    .placeholder(when: city.isEmpty) {
                        Text(Constantes.cityTF).foregroundColor(.black)
                }
                    .frame(height: 50)
                    .background(.secondary)
                    .cornerRadius(15)
                    .padding([.trailing, .leading], 30)
            }
        }
}

struct TFSignUpView_Previews: PreviewProvider {
    
    @State static var email = "adrien@gmail.com"
    @State static var password = "1234"
    @State static var name = "Adrien"
    @State static var lastName = "PEREA"
    @State static var city = "89340 VILLENEUVE LA GUYARD"
    
    static var previews: some View {
        TFSignUpView(email: $email, password: $password, name: $name, lastName: $lastName, city: $city)
            .previewLayout(.sizeThatFits)
    }
}
