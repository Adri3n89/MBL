//
//  BottomLogInView.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI

struct BottomLogInView: View {
    
    @State var showSignUp = false
    
    var body: some View {
        VStack {
            Text(Constantes.noAccount)
                .foregroundColor(.white)
            Button(Constantes.signUp) {
                self.showSignUp.toggle()
            }.fullScreenCover(isPresented: $showSignUp, content: {
                SignUpView()
            })
            .padding([.bottom], 20)
            .tint(.white)
        }
    }
}

struct BottomLogInView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BottomLogInView()
                .previewLayout(.sizeThatFits)
        }
    }
}
