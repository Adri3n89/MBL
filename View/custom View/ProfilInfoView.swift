//
//  ProfilInfoView.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 09/12/2021.
//

import SwiftUI

struct ProfilInfoView: View {
    
    var name: String
    var lastName: String
    @State var showName = false
    @State var showLastName = false
    
    var body: some View {
        VStack(alignment: .leading) {
            CustomTextView(color: .white, text: name, placeholder: String(Constantes.name.dropLast()), buttonText: Constantes.updateName, show: $showName)
            CustomTextView(color: .white, text: lastName, placeholder: String(Constantes.lastName.dropLast()), buttonText: Constantes.updateLastName, show: $showLastName)
        }
        Spacer()
    }
}

struct ProfilInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilInfoView(name: "Adrien", lastName: "PEREA")
    }
}
