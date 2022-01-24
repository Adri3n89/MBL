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
                                viewModel.showAlert.toggle()
                            }
                        .alert(Constantes.changePicture, isPresented: $viewModel.showAlert) {
                            Button(Constantes.camera) {
                                viewModel.sourceType = .camera
                                viewModel.showPicker = true
                            }.disabled(!UIImagePickerController.isCameraDeviceAvailable(.front) && !UIImagePickerController.isCameraDeviceAvailable(.rear))
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
                            Image(systemName: Constantes.power)
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                            .foregroundColor(Color.red)
                            .padding(.trailing, 20)
                    }.sheet(isPresented: $viewModel.showPicker) {
                        ImagePicker(sourceType: viewModel.sourceType, refPic: viewModel.userInfo.refPic)
                    }
                    HStack {
                        Text(Constantes.city)
                            .foregroundColor(.white)
                        Text(viewModel.userInfo.city)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .onTapGesture(perform: {
                                viewModel.showCity.toggle()
                            })
                            .sheet(isPresented: $viewModel.showCity, content: {
                                AlertTFView(placeholder: String(Constantes.city.dropLast()), buttonText: Constantes.updateCity)
                                    .background(BackgroundClearView())
                            })
                    }
                    .padding(5)
                    .background(Color.gray.opacity(0.8))
                    .cornerRadius(10)
                    .frame(maxHeight: 40)
                    .padding([.leading, .trailing])
                    Divider()
                    Picker("", selection: $viewModel.type) {
                        ForEach(Constantes.gameType, id: \.self) {
                            Text($0)
                        }
                    }.alert(viewModel.error, isPresented: $viewModel.showError) {
                        Button(Constantes.cancel, role: .cancel) { }
                    }
                        .pickerStyle(.segmented)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding()
                    Spacer()
                    ScrollView {
                        LazyVGrid(columns: viewModel.columns, spacing: 15) {
                            ForEach(viewModel.gameToShow()) { game in
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
                    viewModel.libraryGames = []
                    viewModel.wishGames = []
                    viewModel.fetchID(type: Constantes.gameType[0])
                    viewModel.fetchID(type: Constantes.gameType[1])
                    viewModel.fetchUserInfo()
               }
               .background(BackgroundView())
               .navigationBarHidden(true)
               .disableAutocorrection(true)
            }
        }
    }
    
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView()
    }
}
