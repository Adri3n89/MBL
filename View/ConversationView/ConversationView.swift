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
            ScrollView {
                ForEach(viewModel.messages) { message in
                    VStack {
                        Text(message.text)
                            .foregroundColor(.white)
                    }
                }
            }.id(UUID())
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
        .background(Image(Constantes.background)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                .blur(radius: 3, opaque: true)
                .opacity(0.90)
        )
        .navigationBarHidden(true)
    }
}

struct ConversationView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        
        let messages: [Message] = [Message(text: "Salut ca va ?", date: "2021-12-01 17:16", userID: "TOTO"),
                                   Message(text: "Bonjour", date: "2021-12-01 17:19", userID: "NONO"),
                                   Message(text: "tu pourrais me preter 7 wonders s'il te plait il est trop bien apparement bla bla bla il faut une grande phrase et bah la voila", date: "2021-12-01 17:23", userID: "TOTO"),
                                   Message(text: "Salut ca va ?", date: "2021-12-01 17:16", userID: "TOTO"),
                                   Message(text: "Bonjour", date: "2021-12-01 17:19", userID: "NONO"),
                                   Message(text: "tu pourrais me preter 7 wonders s'il te plait il est trop bien apparement bla bla bla il faut une grande phrase et bah la voila", date: "2021-12-01 17:23", userID: "TOTO"),
                                   Message(text: "Salut ca va ?", date: "2021-12-01 17:16", userID: "TOTO"),
                                   Message(text: "Bonjour", date: "2021-12-01 17:19", userID: "NONO"),
                                   Message(text: "tu pourrais me preter 7 wonders s'il te plait il est trop bien apparement bla bla bla il faut une grande phrase et bah la voila", date: "2021-12-01 17:23", userID: "TOTO"),
                                   Message(text: "Salut ca va ?", date: "2021-12-01 17:16", userID: "TOTO"),
                                   Message(text: "Bonjour", date: "2021-12-01 17:19", userID: "NONO"),
                                   Message(text: "tu pourrais me preter 7 wonders s'il te plait il est trop bien apparement bla bla bla il faut une grande phrase et bah la voila", date: "2021-12-01 17:23", userID: "TOTO"),
                                   Message(text: "Salut ca va ?", date: "2021-12-01 17:16", userID: "TOTO"),
                                   Message(text: "Bonjour", date: "2021-12-01 17:19", userID: "NONO"),
                                   Message(text: "tu pourrais me preter 7 wonders s'il te plait il est trop bien apparement bla bla bla il faut une grande phrase et bah la voila", date: "2021-12-01 17:23", userID: "TOTO"),
                                   Message(text: "Salut ca va ?", date: "2021-12-01 17:16", userID: "TOTO"),
                                   Message(text: "Bonjour", date: "2021-12-01 17:19", userID: "NONO"),
                                   Message(text: "tu pourrais me preter 7 wonders s'il te plait il est trop bien apparement bla bla bla il faut une grande phrase et bah la voila", date: "2021-12-01 17:23", userID: "TOTO")
        ]
        
        ConversationView(viewModel: ConversationViewModel(messages: messages, userInfo: UserData(name: "Jean", lastName: "Dupont", userID: "DFJDK", city: "89340 VILLENEUVE LA GUYARD", picture: "https://i.imgur.com/42ZTgTc.png", refPic: ""), conversationID: "DJDONOUNOZUD"))
    }
}
