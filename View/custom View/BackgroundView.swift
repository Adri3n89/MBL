//
//  BackgroundView.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 15/12/2021.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Image(Constantes.background)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                .opacity(0.90)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
