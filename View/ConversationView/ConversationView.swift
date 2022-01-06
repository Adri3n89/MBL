//
//  ConversationView.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 30/11/2021.
//

import SwiftUI

struct ConversationView: View {
    
    @ObservedObject var viewModel: ConversationViewModel
    @Environment(\.presentationMode) var presentationMode
    init(viewModel: ConversationViewModel) {
        self.viewModel = viewModel
            UITextView.appearance().backgroundColor = .clear
        }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: Constantes.arrowShape)
                }
                    .padding([.leading, .trailing], 20)
                AsyncImage(url: URL(string: viewModel.userInfo.picture), content: { image in
                    image
                        .resizable()
                }, placeholder: {
                    Color.purple.opacity(0.1)
                })
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(
                       Circle()
                           .stroke(.white, lineWidth: 3)
                   )
                   .padding([.trailing], 15)
                Text(viewModel.userName())
                    .foregroundColor(.white)
                Spacer()
            }
            ScrollViewReader { value in
                ScrollView {
                    ForEach(viewModel.messages) { message in
                        if message.userID == viewModel.conversationRepo.currentUserID {
                            RightBubbleView(text: message.text)
                                .id(message.id)
                        } else {
                            LeftBubbleView(text: message.text)
                                .id(message.id)
                        }
                    }
                }.onAppear {
                    value.scrollTo(viewModel.messages.last?.id)
                }
                .onChange(of: viewModel.messages.count) { _ in
                    value.scrollTo(viewModel.messages.last?.id)
                }
            }
            HStack {
                TextEditor(text: $viewModel.newMessage)
                    .background(Color.gray)
                    .frame(height: 50)
                    .padding()
                Button {
                    viewModel.sendMessage()
                } label: {
                    Image(systemName: Constantes.paperplane)
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                .padding([.leading,.trailing])

            }
            .background(Color.black)
        }.onAppear(perform: {
            viewModel.fetchConversation()
        })
        .background(BackgroundView())
        .navigationBarHidden(true)
    }
}

struct ConversationView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        
        ConversationView(viewModel: ConversationViewModel(userInfo: UserData(name: "Jean", lastName: "Dupont", userID: "DFJDK", city: "89340 VILLENEUVE LA GUYARD", picture: "https://i.imgur.com/42ZTgTc.png", refPic: ""), conversationID: "DJDONOUNOZUD"))
    }
}
