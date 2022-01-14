//
//  CustomSecureTF.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 13/12/2021.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI

struct CustomSecureTF: View {
    
    @Binding var text: String
    let placeholder: String
    @State var isTextShow: Bool
    
    var body: some View {
        FloatingLabelTextField($text, placeholder: placeholder, editingChanged: { isChanged in }, commit: {})
        .selectedLineColor(.white)
        .selectedTitleColor(.white)
        .selectedTextColor(.white)
        .titleColor(.white)
        .textColor(.white)
        .lineColor(.white)
        .placeholderColor(.white)
        .isSecureTextEntry(!isTextShow)
        .rightView({
            Button {
                withAnimation {
                    isTextShow.toggle()
                }
            } label: {
                Image(systemName: isTextShow ? Constantes.showPassword : Constantes.hidePassword)
            }
        })
        .padding(5)
        .background(Color.gray.opacity(0.8))
        .cornerRadius(10)
        .padding([.trailing, .leading], 30)
        .padding(.bottom, 20)
        .frame(height: 80)
    }
}

struct CustomSecureTF_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecureTF(text: .constant("bonjour"), placeholder: "My password", isTextShow: false)
    }
}
