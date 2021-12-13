//
//  FTSignUpView.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI

struct TFSignUpView: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var name: String
    @Binding var lastName: String
    @Binding var city: String
        
        var body: some View {
            VStack {
                TFView(email: $email, password: $password)
                CustomTF(text: $name, placeholder: Constantes.nameTF)
                CustomTF(text: $lastName, placeholder: Constantes.lastNameTF)
                CustomTF(text: $city, placeholder: Constantes.cityTF)
            }.disableAutocorrection(true)
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
