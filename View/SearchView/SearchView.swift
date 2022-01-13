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
                TextField(Constantes.searchGame, text: $viewModel.gameName)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .foregroundColor(.black)
                if viewModel.isLoading == false {
                    Button {
                        viewModel.isLoading = true
                        viewModel.searchGame()
                    } label: {
                        Text(Constantes.search)
                    }
                    .frame(height: 50)
                    .padding([.leading, .trailing], 10)
                    .background(.gray)
                    .cornerRadius(15)
                    .foregroundColor(.white)
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .scaleEffect(1.5)
                        .padding()
                }
                ScrollView {
                    ForEach(viewModel.searchResult) { game in
                        NavigationLink {
                            DetailsView(id: game.id)
                        } label: {
                            Text("- \(game.name.value)")
                                .glowBorder(color: .white, lineWidth: 4)
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
            .background(BackgroundView())
            .navigationBarHidden(true)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
