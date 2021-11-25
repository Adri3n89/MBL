//
//  TopLogInView.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack {
            Text(Constantes.mgl)
                .font(.largeTitle)
            Text(Constantes.myGameBoard)
                .font(.title2)
        }
        .padding(40)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
            .previewLayout(.sizeThatFits)
    }
}
