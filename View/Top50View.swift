//
//  Top50View.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct Top50View: View {
    
    @StateObject var api = ApiService()
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 5) {
                        ForEach(api.top50) { top in
                            NavigationLink {
                                DetailsView(id: top.id)
                            } label: {
                                GameCellView(game: top, width: geo.size.width)
                            }
                            .foregroundColor(Color.black)
                        }
                    }
                }
                .onAppear {
                    if api.top50.count == 0 {
                        api.getHotGame()
                    }
                }
                .navigationBarHidden(true)
            }
        }
    }
}

struct Top50View_Previews: PreviewProvider {
    static var previews: some View {
        Top50View()
    }
}
