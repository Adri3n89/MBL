//
//  MapPinView.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 19/11/2021.
//

import SwiftUI

struct MapPinView: View {
    
    @State private var showTitle = true
    let name: String
    let lastName: String
  
  var body: some View {
    VStack(spacing: 0) {
      Text(name + " " + lastName)
        .font(.callout)
        .padding(5)
        .background(Color(.white))
        .cornerRadius(10)
        .opacity(showTitle ? 0 : 1)
      
      Image(systemName: "mappin.circle.fill")
        .font(.title)
        .foregroundColor(.red)
      
      Image(systemName: "arrowtriangle.down.fill")
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
        MapPinView(name: "Adrien", lastName: "PEREA")
            .previewLayout(.sizeThatFits)
    }
}
