//
//  Top50View.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct Top50View: View {
    let api = ApiService()
    @State var top50: [GameData] = []
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                Text("Top 50")
                    .onAppear {
                        api.getHotGame { succes, top50 in
                            if succes, top50 != nil {
                                self.top50 = top50!
                            }
                        }
                    }
                ForEach(top50) { top in
                    GameCellView(game: top, width: geo.size.width)
                }
            }
        }
    }
}

struct Top50View_Previews: PreviewProvider {
    static var previews: some View {
        Top50View()
    }
}
