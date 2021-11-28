//
//  DetailsView.swift
//  MGL
//
//  Created by Adrien PEREA on 14/11/2021.
//

import SwiftUI

struct DetailsView: View {
    
    @State var id: String
    @ObservedObject var viewModel = DetailsViewModel()
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            ScrollView {
                VStack(alignment: .center) {
                    HStack {
                        Spacer()
                        AsyncImage(url: URL(string: viewModel.gameInfo?.image ?? "")) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipped()
                                .cornerRadius(20)
                        } placeholder: {
                            Color.purple.opacity(0.1)
                        } .frame(width: width/2, height: width/2)
                        Spacer()
                    }
                    VStack {
                        Text(Constantes.year + (viewModel.gameInfo?.yearpublished.value ?? "?"))
                        Text(Constantes.player + (viewModel.gameInfo?.minplayers.value ?? "") + "-" + (viewModel.gameInfo?.maxplayers.value ?? ""))
                        Text(Constantes.time + (viewModel.gameInfo?.minplaytime.value ?? "") + "-" + (viewModel.gameInfo?.maxplaytime.value ?? ""))
                    }
                    .padding()
                    .background(Color.secondary)
                    .cornerRadius(10)
                    .padding()
                    HStack {
                        Spacer()
                        Button {
                            viewModel.addToLibrary(id: id)
                        } label: {
                            Text(viewModel.libraryButtonText)
                        }
                        .padding(3)
                        .background(Color.secondary)
                        .cornerRadius(10)
                        Spacer()
                        Button {
                            viewModel.addToWishlist(id: id)
                        } label: {
                            Text(viewModel.wishListButtonText)
                        }
                        .padding(3)
                        .background(Color.secondary)
                        .cornerRadius(10)
                        Spacer()
                    }
                    Divider()
                    Text(viewModel.gameInfo?.itemDescription.decodingUnicodeCharacters ?? Constantes.noDescription)
                        .padding(3)
                        .background(Color.secondary)
                        .cornerRadius(10)
                        .padding(10)
                }
            }
            .foregroundColor(.white)
            .background(Image(Constantes.background)
                            .resizable()
                            .ignoresSafeArea()
                            .scaledToFill()
                            .blur(radius: 3, opaque: true)
                            .opacity(0.90)
            )
            .onAppear {
                viewModel.id = id
                viewModel.getWishID()
                viewModel.getLibraryID()
                viewModel.getDetail()
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(id: "")
    }
}
