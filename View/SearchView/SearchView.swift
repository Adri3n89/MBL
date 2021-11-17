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
                TextField("Search", text: $viewModel.gameName, prompt: Text("enter your game name here"))
                    .padding()
                    .border(.secondary, width: 2)
                    .padding()
                Button {
                    viewModel.searchGame()
                } label: {
                    Text("Search")
                }
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
            .navigationBarHidden(true)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
