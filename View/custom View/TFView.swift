//
//  TFView.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI

struct TFView: View {
    
    @Binding var email: String
    @Binding var password: String
    @State var isPasswordShow: Bool = false
    
    var body: some View {
        VStack {
            CustomTF(text: $email, placeholder: Constantes.emailTF)
                .keyboardType(.emailAddress)
            CustomSecureTF(text: $password, placeholder: Constantes.passwordTF, isTextShow: isPasswordShow)
        }.disableAutocorrection(true)
    }
}

struct TFView_Previews: PreviewProvider {
    
    @State static var email = ""
    @State static var password = "1234"
    
    static var previews: some View {
        TFView(email: $email, password: $password)
            .previewLayout(.sizeThatFits)
    }
}
