//
//  RightBubbleView.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 04/12/2021.
//

import SwiftUI

struct RightBubbleView: View {
    
    var text: String
    
    var body: some View {
        HStack {
            Spacer()
            Text(text)
                .padding(5)
                .background(.green)
                .cornerRadius(8)
                .padding(.trailing)
                .frame(maxWidth: 200, alignment: .trailing)
        }
    }
}

struct RightBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        RightBubbleView(text: "Salut comment ca va ? je voudrais savoir si un peux me preter un jeu pour ce week end ?")
    }
}
