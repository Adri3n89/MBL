//
//  PublicProfilView.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 21/11/2021.
//

import SwiftUI

struct PublicProfilView: View {
    
    @ObservedObject var viewModel = PublicProfilViewModel()
    @State var image = UIImage()
    var userID: String
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Image(uiImage: image)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .background(Color.red)
                            .clipShape(Circle())
                            .padding([.leading, .trailing], 30)
                    VStack(alignment: .leading) {
                        Text(viewModel.userInfo.name)
                            .padding([.bottom], 20)
                        Text(viewModel.userInfo.lastName)
                    }
                    Spacer()
                    Button {
                      
                    } label: {
                        Text(Constantes.contact)
                        Image(systemName: Constantes.envelope)
                    }
                    Spacer()
                }
                .padding()
                Divider()
                HStack {
                    Text(Constantes.city)
                    Text(viewModel.userInfo.city)
                        .multilineTextAlignment(.leading)
                }.padding()
                Spacer()
                ScrollView {
                    LazyVGrid(columns: viewModel.columns, spacing: 15) {
                        ForEach(viewModel.libraryGames) { game in
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
            .foregroundColor(.white)
                .background(Image(Constantes.background)
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                        .blur(radius: 3, opaque: true)
                        .opacity(0.90)
                )
                .onAppear {
                    viewModel.fetchLibraryID(user: userID)
                    viewModel.fetchUserInfo(user: userID)
                }
                .navigationBarHidden(true)
            }
        }
    }
}

struct PublicProfilView_Previews: PreviewProvider {
    static var previews: some View {
        PublicProfilView(userID: "preview")
    }
}
