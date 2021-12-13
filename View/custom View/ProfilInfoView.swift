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
            Text(name)
                .foregroundColor(.white)
                .onTapGesture(perform: {
                    showName.toggle()
                })
                .sheet(isPresented: $showName, content: {
                    AlertTFView(placeholder: "Name", buttonText: "Update your name")
                        .background(BackgroundClearView())
                })
                .padding([.bottom], 20)
            Text(lastName)
                .foregroundColor(.white)
                .onTapGesture(perform: {
                    showLastName.toggle()
                })
                .sheet(isPresented: $showLastName, content: {
                    AlertTFView(placeholder: "LastName", buttonText: "Update your lastname")
                        .background(BackgroundClearView())
                })
        }
        Spacer()
    }
}

struct ProfilInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilInfoView(name: "Adrien", lastName: "PEREA")
    }
}
