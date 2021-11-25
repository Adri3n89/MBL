//
//  DetailsView.swift
//  MGL
//
//  Created by Adrien PEREA on 14/11/2021.
//

import SwiftUI

struct DetailsView: View {
    
    @State var id: String
    @StateObject var viewModel = DetailsViewModel()
    
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
                        } placeholder: {
                            Color.purple.opacity(0.1)
                        } .frame(width: width/2, height: width/2)
                        Spacer()
                    }
                    VStack {
                        Text(Constantes.year + (viewModel.gameInfo?.yearpublished.value ?? "?"))
                        Text(Constantes.player + (viewModel.gameInfo?.minplayers.value ?? "") + "-" + (viewModel.gameInfo?.maxplayers.value ?? ""))
                        Text(Constantes.time + (viewModel.gameInfo?.minplaytime.value ?? "") + "-" + (viewModel.gameInfo?.maxplaytime.value ?? ""))
                    }.padding()
                    HStack {
                        Spacer()
                        Button {
                            // modifier par "delete from library" si déja dedans
                            viewModel.addToLibrary(id: id)
                        } label: {
                            Text(viewModel.libraryButtonText)
                        }
                        Spacer()
                        Button {
                            // modifier par "delete from wishlist" si déja dedans
                            viewModel.addToWishlist(id: id)
                        } label: {
                            Text(viewModel.wishListButtonText)
                        }
                        Spacer()
                    }
                    Divider()
                    Text(viewModel.gameInfo?.itemDescription.decodingUnicodeCharacters ?? Constantes.noDescription)
                        .padding()
                }
            }
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
