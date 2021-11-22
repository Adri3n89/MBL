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
                    Text("name :")
                    Spacer()
                }
                .padding([.trailing, .leading], 30)
                TextField("name", text: $name)
                    .placeholder(when: name.isEmpty) {
                        Text(" Enter your name here").foregroundColor(.black)
                }
                    .background(.secondary)
                    .cornerRadius(5)
                    .padding([.trailing, .leading], 30)
                HStack {
                    Text("last name :")
                    Spacer()
                }
                .padding([.trailing, .leading], 30)
                TextField("last name", text: $lastName)
                    .placeholder(when: lastName.isEmpty) {
                        Text(" Enter your last name here").foregroundColor(.black)
                }
                    .background(.secondary)
                    .cornerRadius(5)
                    .padding([.trailing, .leading], 30)
                HStack {
                    Text("city : (ex 77000 MELUN)")
                    Spacer()
                }
                .padding([.trailing, .leading], 30)
                TextField("city", text: $city)
                    .placeholder(when: city.isEmpty) {
                        Text(" Enter your city here").foregroundColor(.black)
                }
                    .background(.secondary)
                    .cornerRadius(5)
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
