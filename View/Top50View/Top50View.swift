//
//  Top50View.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI

struct Top50View: View {
    
    @StateObject private var viewModel = Top50ViewModel()
    
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
                            }
                            .foregroundColor(Color.black)
                        }
                    }
                }
                .padding(.horizontal)
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
