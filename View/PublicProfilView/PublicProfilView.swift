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
                    ProfilImageView(imageURL: viewModel.userInfo.picture)
                        .disabled(true)
                    ProfilInfoView(name: viewModel.userInfo.name, lastName: viewModel.userInfo.lastName)
                        .disabled(true)
                    Button {
                        viewModel.createConversation()
                    } label: {
                        Image(systemName: Constantes.envelope)
                            .padding(5)
                            .background(Color.gray.opacity(0.8))
                            .cornerRadius(10)
                            .padding(.trailing, 20)
                        
                    }.foregroundColor(.white)
                        .fullScreenCover(isPresented: $viewModel.showConversation) {
                            ConversationView(viewModel: ConversationViewModel(userInfo: viewModel.returnGoodUser(userID: viewModel.conversationRepo.currentUserID!), conversationID: viewModel.conversation!.conversationID))
                        }
                        .alert(viewModel.message, isPresented: $viewModel.showMessage) {
                            Button(Constantes.cancel, role: .cancel) { }
                        }
                }
                .padding(.top)
                HStack {
                    Text(Constantes.city)
                    Text(viewModel.userInfo.city)
                        .multilineTextAlignment(.leading)
                        .disabled(true)
                }
                .padding(5)
                .background(Color.gray.opacity(0.8))
                .cornerRadius(10)
                .frame(maxHeight: 40)
                .padding([.leading, .trailing])
                Divider()
                Spacer()
                ScrollView {
                    LazyVGrid(columns: viewModel.columns, spacing: 15) {
                        ForEach(viewModel.libraryGames) { game in
                            NavigationLink {
                                DetailsView(id: game.id)
                            } label: {
                                GameCellView(game: game, width: geo.size.width)
                            }
                        }
                    }
                        .padding()
                    }
                }
            .foregroundColor(.white)
                .background(BackgroundView())
                .onAppear {
                    viewModel.libraryGames = []
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
