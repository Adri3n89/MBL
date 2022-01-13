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
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            ScrollView {
                VStack(alignment: .center) {
                    HStack {
                        Spacer()
                        AsyncImage(url: URL(string: viewModel.gamePicture())) { image in
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
                        Text(viewModel.gameYear())
                        Text(viewModel.players())
                        Text(viewModel.playTime())
                    }
                    .padding()
                    .background(Color.secondary)
                    .cornerRadius(10)
                    .padding()
                    HStack {
                        Spacer()
                        Button {
                            viewModel.addOrRemove(id: id, type: Constantes.gameType[0])
                        } label: {
                            Text(viewModel.libraryButtonText)
                        }
                        .padding(3)
                        .background(Color.secondary)
                        .cornerRadius(10)
                        Spacer()
                        Button {
                            viewModel.addOrRemove(id: id, type: Constantes.gameType[1])
                        } label: {
                            Text(viewModel.wishListButtonText)
                        }
                        .padding(3)
                        .background(Color.secondary)
                        .cornerRadius(10)
                        Spacer()
                    }
                    Divider()
                    Text(viewModel.description())
                        .padding(3)
                        .background(Color.secondary)
                        .cornerRadius(10)
                        .padding(10)
                }
            }
            .foregroundColor(.white)
            .background(BackgroundView())
            .onAppear {
                viewModel.id = id
                viewModel.getIDs(type: Constantes.gameType[0])
                viewModel.getIDs(type: Constantes.gameType[1])
                viewModel.getDetail()
            }
            .onChange(of: viewModel.result) { newValue in
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(id: "")
    }
}
