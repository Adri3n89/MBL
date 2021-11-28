//
//  SearchView.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("", text: $viewModel.gameName)
                    .placeholder(when: viewModel.gameName.isEmpty) {
                        Text(Constantes.searchGame).foregroundColor(.white)
                }
                    .padding()
                    .border(.white, width: 2)
                    .padding()
                    .foregroundColor(.white)
                Button {
                    viewModel.searchGame()
                } label: {
                    Text(Constantes.search)
                }
                .foregroundColor(.white)
                ScrollView {
                    ForEach(viewModel.searchResult) { game in
                        NavigationLink {
                            DetailsView(id: game.id)
                        } label: {
                            Text("- \(game.name.value)")
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .foregroundColor(Color.white)
                    }
                }
                .padding()
            }
            .alert(viewModel.error, isPresented: $viewModel.showError) {
                Button(Constantes.ok, role: .cancel) { }
            }
            .background(Image(Constantes.background)
                            .resizable()
                            .ignoresSafeArea()
                            .scaledToFill()
                            .blur(radius: 3, opaque: true)
                            .opacity(0.90)
            )
            .navigationBarHidden(true)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
