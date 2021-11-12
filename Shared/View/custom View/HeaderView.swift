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
            Text("M.G.L")
                .font(.largeTitle)
            Text("My GameBoard Library")
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
