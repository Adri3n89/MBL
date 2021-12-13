//
//  ProfilImageView.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 09/12/2021.
//

import SwiftUI

struct ProfilImageView: View {
    
    var imageURL: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL), content: { image in
            image
                .resizable()
        }, placeholder: {
            Color.purple.opacity(0.1)
        })
            .frame(width: 80, height: 80)
            .clipShape(Circle())
            .overlay(
               Circle()
                   .stroke(.white, lineWidth: 3)
           )
           .padding([.leading, .trailing], 30)
    }
}

struct ProfilImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilImageView(imageURL: "")
    }
}
