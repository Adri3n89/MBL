//
//  ConversationCellView.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 30/11/2021.
//

import SwiftUI

struct ConversationCellView: View {
    
    @State var name: String
    @State var imageURL: String
    @State var lastMessage: String?
    
    var body: some View {
        HStack {
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
               .padding([.leading, .trailing], 20)
            VStack {
                Text(name)
                    .frame(height: 15)
                Divider()
                Text(lastMessage ?? Constantes.noMessage)
                    .frame(height: 15)
            }
            .padding()
            .background(.gray.opacity(0.7))
            .foregroundColor(.white)
            .cornerRadius(25)
            Spacer()
        }
    }
}

struct ConversationCellView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationCellView(name: "Jose Luis De la Vega", imageURL: "")
            .previewLayout(.sizeThatFits)
    }
}
