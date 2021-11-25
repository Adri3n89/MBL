//
//  TFView.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI

struct TFView: View {
    
    @Binding var email: String
    @Binding var password: String
    var body: some View {
        VStack {
            HStack {
                Text(Constantes.email)
                Spacer()
            }
            .padding([.trailing, .leading], 30)
            TextField("", text: $email)
                .placeholder(when: email.isEmpty) {
                    Text(Constantes.emailTF).foregroundColor(.black)
            }
                .frame(height: 50)
                .background(.secondary)
                .cornerRadius(15)
                .padding([.trailing, .leading], 30)
            HStack {
                Text(Constantes.password)
                Spacer()
            }
            .padding([.trailing, .leading], 30)
            SecureField("", text: $password)
                .placeholder(when: password.isEmpty) {
                    Text(Constantes.passwordTF).foregroundColor(.black)
            }
                .frame(height: 50)
                .background(.secondary)
                .cornerRadius(15)
                .padding([.trailing, .leading], 30)
        }
    }
}

struct TFView_Previews: PreviewProvider {
    
    @State static var email = "adrien@gmail.com"
    @State static var password = "1234"
    
    static var previews: some View {
        TFView(email: $email, password: $password)
            .previewLayout(.sizeThatFits)
    }
}
