//
//  ProfilView.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI

struct ProfilView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel = ProfilViewModel()
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack(alignment: .leading) {
                    HStack {
                        ProfilImageView(imageURL: viewModel.userInfo.picture)
                            .onTapGesture {
                                viewModel.updatePicture()
                            }
                        .alert(Constantes.changePicture, isPresented: $viewModel.showAlert) {
                            Button(Constantes.camera) {
                                viewModel.sourceType = .camera
                                viewModel.showPicker = true
                            }
                            Button(Constantes.gallery) {
                                viewModel.sourceType = .photoLibrary
                                viewModel.showPicker = true
                            }
                            Button(Constantes.cancel, role: .cancel) { }
                        }
                        ProfilInfoView(name: viewModel.userInfo.name, lastName: viewModel.userInfo.lastName)
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            viewModel.logOut()
                        } label: {
                            Text(Constantes.logOut)
                            Image(systemName: Constantes.power)
                        }
                            .foregroundColor(Color.red)

                        Spacer()
                    }.sheet(isPresented: $viewModel.showPicker) {
                        ImagePicker(sourceType: viewModel.sourceType, refPic: viewModel.userInfo.refPic)
                    }
                    Divider()
                    HStack {
                        Text(Constantes.city)
                        Text(viewModel.userInfo.city)
                            .multilineTextAlignment(.leading)
                            .onTapGesture(perform: {
                                viewModel.showCity.toggle()
                            })
                            .sheet(isPresented: $viewModel.showCity, content: {
                                AlertTFView(placeholder: "City", buttonText: "Update your city")
                                    .background(BackgroundClearView())
                            })
                    }
                        .padding()
                        .foregroundColor(.white)
                    Picker("", selection: $viewModel.type) {
                        ForEach(viewModel.allType, id: \.self) {
                            Text($0)
                        }
                    }
                        .pickerStyle(.segmented)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding()
                    Spacer()
                    ScrollView {
                        LazyVGrid(columns: viewModel.columns, spacing: 15) {
                            ForEach(viewModel.type == viewModel.allType[0] ? viewModel.libraryGames : viewModel.wishGames) { game in
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
                .background(Image(Constantes.background)
                            .resizable()
                            .ignoresSafeArea()
                            .scaledToFill()
                            .blur(radius: 3, opaque: true)
                            .opacity(0.90)
                )
                .onAppear {
                    viewModel.fetchWishlistID()
                    viewModel.fetchLibraryID()
                    viewModel.fetchUserInfo()
                }
                .navigationBarHidden(true)
            }
        }
    }
    
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView()
    }
}
