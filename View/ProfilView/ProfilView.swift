//
//  ProfilView.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI

struct ProfilView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = ProfilViewModel()
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "person.circle")
                            .frame(width: 80, height: 80)
                            .background(Color.red)
                            .clipShape(Circle())
                            .padding([.leading, .trailing], 30)
                        VStack(alignment: .leading) {
                            Text("Adrien")
                                .padding([.bottom], 20)
                            Text("PEREA")
                        }
                        Spacer()
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("logout")
                            Image(systemName: "power.circle.fill")
                        }
                        .foregroundColor(Color.red)

                        Spacer()
                    }
                    Divider()
                    HStack {
                        Text("Adress :")
                        Text("89340 VILLENEUVE LA GUYARD ET BLA BLA BLA BLA BLA ")
                            .multilineTextAlignment(.leading)
                    }
                    Picker("type", selection: $viewModel.type) {
                        ForEach(viewModel.allType, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    Spacer()
                    ScrollView {
                        LazyVGrid(columns: viewModel.columns, spacing: 15) {
                            ForEach(viewModel.type == "library" ? viewModel.libraryGames : viewModel.wishGames) { game in
                                NavigationLink {
                                    DetailsView(id: game.id)
                                } label: {
                                    GameCellView(game: game, width: geo.size.width)
                                }
                                .foregroundColor(Color.black)
                            }
                        }
                        .padding()
                    }
                }
                .onAppear {
                    viewModel.fetchWishlistID()
                    viewModel.fetchLibraryID()
                }
            }
        }
    }
    
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView()
    }
}
