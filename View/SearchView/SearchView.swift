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
                    .disableAutocorrection(true)
                if viewModel.isLoading == false {
                    Button {
                        viewModel.isLoading = true
                        viewModel.searchGame()
                    } label: {
                        Text(Constantes.search)
                    }
                    .frame(height: 40)
                    .padding([.leading, .trailing], 10)
                    .background(.gray.opacity(0.8))
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
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(game.name.value)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                            }
                            .padding()
                            .background(Color.gray.opacity(0.8))
                            .cornerRadius(10)
                        }
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
