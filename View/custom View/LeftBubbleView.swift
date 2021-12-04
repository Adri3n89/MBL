//
//  LeftBubbleView.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 04/12/2021.
//

import SwiftUI

struct LeftBubbleView: View {
    var text: String
    
    var body: some View {
        HStack {
            Text(text)
                .padding(5)
                .background(.blue)
                .cornerRadius(8)
                .padding(.leading)
                .frame(maxWidth: 200, alignment: .leading)
            Spacer()
        }
    }
}

struct LeftBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        LeftBubbleView(text: "Salut ca va ?  je voulais savoir si tu pouvais me preter seven wonders ?")
    }
}
