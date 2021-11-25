//
//  MapPinView.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 19/11/2021.
//

import SwiftUI
import CoreLocation

struct MapPinView: View {
    
    @State private var showTitle = true
    @State var showLibrary = false
    let user: PinInfo
  
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Text(user.name + " " + user.lastName)
                Divider()
                Button {
                    showLibrary.toggle()
                } label: {
                    Text(Constantes.gameType[0])
                }.sheet(isPresented: $showLibrary) {
                    PublicProfilView(userID: user.userID)
                }
            }
            .font(.callout)
            .padding()
            .background(Color(.white))
            .cornerRadius(10)
            .opacity(showTitle ? 0 : 1)
            Image(systemName: Constantes.mappPin)
            .font(.title)
            .foregroundColor(.red)
          
            Image(systemName: Constantes.arrow)
            .font(.caption)
            .foregroundColor(.red)
            .offset(x: 0, y: -5)
        }
        .onTapGesture {
              withAnimation(.easeInOut) {
                showTitle.toggle()
              }
        }
    }
}

struct MapPinView_Previews: PreviewProvider {
    static var previews: some View {
        MapPinView(user: PinInfo(id: UUID(), name: "Adrien", lastName: "PEREA", userID: "43", coordinates: CLLocationCoordinate2D()))
            .previewLayout(.sizeThatFits)
    }
}
