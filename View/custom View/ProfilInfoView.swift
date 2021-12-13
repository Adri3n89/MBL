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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .padding([.bottom], 20)
            Text(lastName)
        }
            .foregroundColor(.white)
        Spacer()
    }
}

struct ProfilInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilInfoView(name: "Adrien", lastName: "PEREA")
    }
}
