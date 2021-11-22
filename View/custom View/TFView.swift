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
            TextField("email", text: $email, prompt:Text(" Enter your mail here"))
                .background(.secondary)
                .padding([.trailing, .leading], 30)
            HStack {
                Text("password :")
                Spacer()
            }
            .padding([.trailing, .leading], 30)
            SecureField("password", text: $password, prompt:Text(" Enter your password here"))
                .background(.secondary)
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
