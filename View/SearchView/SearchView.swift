//
//  SearchView.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField(Constantes.search, text: $viewModel.gameName, prompt: Text(Constantes.searchGame))
                    .padding()
                    .border(.secondary, width: 2)
                    .padding()
                Button {
                    viewModel.searchGame()
                } label: {
                    Text(Constantes.search)
                }
                .foregroundColor(.black)
                ScrollView {
                    ForEach(viewModel.searchResult) { game in
                        NavigationLink {
                            DetailsView(id: game.id)
                        } label: {
                            Text("- \(game.name.value)")
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .foregroundColor(Color.black)
                    }
                }
                .padding()
            }
            .alert(viewModel.error, isPresented: $viewModel.showError) {
                Button(Constantes.ok, role: .cancel) { }
            }
            .navigationBarHidden(true)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
