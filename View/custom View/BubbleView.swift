//
//  LeftBubbleView.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 04/12/2021.
//

import SwiftUI

struct BubbleView: View {
    var text: String
    var isLeft: Bool
    var body: some View {
        HStack {
            if !isLeft {
                Spacer()
            }
            Text(text)
                .padding(5)
                .foregroundColor(.white)
                .background(isLeft ? .gray.opacity(0.8) : .black.opacity(0.8))
                .cornerRadius(8)
                .padding(isLeft ? .leading : .trailing)
                .frame(maxWidth: 200, alignment: isLeft ? .leading : .trailing)
            if isLeft {
                Spacer()
            }
        }
    }
}

struct LeftBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleView(text: "Salut ca va ?  je voulais savoir si tu pouvais me preter seven wonders ?", isLeft: true)
    }
}
