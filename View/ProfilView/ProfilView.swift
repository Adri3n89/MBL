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
    @State var image = UIImage()
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack(alignment: .leading) {
                    HStack {
                        Button {
                            // changer la photo de profil
                            viewModel.updatePicture()
                        } label: {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 80, height: 80)
                                .background(Color.red)
                                .clipShape(Circle())
                                .padding([.leading, .trailing], 30)
                        }.alert(Constantes.changePicture, isPresented: $viewModel.showAlert) {
                            Button(Constantes.camera) {
                                viewModel.sourcePicker = .camera
                                viewModel.showPicker = true
                            }
                            Button(Constantes.gallery) {
                                viewModel.sourcePicker = .photoLibrary
                                viewModel.showPicker = true
                            }
                            Button(Constantes.cancel, role: .cancel) { }
                        }
                        VStack(alignment: .leading) {
                            Text(viewModel.userInfo.name)
                                .padding([.bottom], 20)
                            Text(viewModel.userInfo.lastName)
                        }
                            .foregroundColor(.white)
                        Spacer()
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
                        ImagePicker(sourceType: viewModel.sourcePicker, selectedImage: $image)
                    }
                    Divider()
                    HStack {
                        Text(Constantes.city)
                        Text(viewModel.userInfo.city)
                            .multilineTextAlignment(.leading)
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
