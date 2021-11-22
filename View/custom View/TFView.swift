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
                Text("e-mail :")
                Spacer()
            }
            .padding([.trailing, .leading], 30)
            TextField("email", text: $email)
                .placeholder(when: email.isEmpty) {
                    Text(" Enter your email here").foregroundColor(.black)
            }
                .background(.secondary)
                .cornerRadius(5)
                .padding([.trailing, .leading], 30)
            HStack {
                Text("password :")
                Spacer()
            }
            .padding([.trailing, .leading], 30)
            SecureField("password", text: $password)
                .placeholder(when: password.isEmpty) {
                    Text(" Enter your password here").foregroundColor(.black)
            }
                .background(.secondary)
                .cornerRadius(5)
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
