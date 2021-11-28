//
//  Top50View.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI

struct Top50View: View {
    
    @ObservedObject private var viewModel = Top50ViewModel()
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: viewModel.columns, spacing: 15) {
                        ForEach(viewModel.top50) { top in
                            NavigationLink {
                                DetailsView(id: top.id)
                            } label: {
                                GameCellView(game: top, width: geo.size.width)
                                    .shadow(color: .black, radius: 2, x: 2, y: 2)
                            }
                            .foregroundColor(Color.black)
                        }
                    }
                }
                .padding(.horizontal)
                .background(Image(Constantes.background)
                                .resizable()
                                .ignoresSafeArea()
                                .scaledToFill()
                                .blur(radius: 3, opaque: true)
                                .opacity(0.90)
                )
                .onAppear {
                    viewModel.getTop50()
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
