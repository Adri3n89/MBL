//
//  GameCellView.swift
//  MGL
//
//  Created by Adrien PEREA on 14/11/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameCellView: View {
    var game: GameData?
    var width: CGFloat

    var body: some View {
        ZStack {
            WebImage(url: URL(string: game!.image))
                .resizable()
                .scaledToFill()
            
                .frame(width: (width / 2.3) , height: (width / 2.3), alignment: .center)
                .clipped()
            Text(game!.year ?? "?")
                .offset(x: -(width / 2.3)/3.1, y: -(width / 2.3)/2.5)
            Text(game!.rank)
                .offset(x: (width / 2.3)/2.5, y: -(width / 2.3)/2.5)
            Text(game!.name)
                .offset(x: 0, y: (width / 2.3)/3)
                .frame(width: width / 2.3, height: (width / 2.3)/3, alignment: .center)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.01)
        }.frame(width: (width / 2.3) , height: (width / 2.3) , alignment: .center)
    }
}

struct GameCellView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameCellView(width: 300)
                .previewLayout(.sizeThatFits)
        }
    }
}
