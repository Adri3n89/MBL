//
//  ChatView.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI

struct ChatView: View {
    
    @ObservedObject var viewModel = ChatViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.allConversations.count == 0 {
                    Text(Constantes.noConversation)
                } else {
                    ForEach(viewModel.allConversations, content: { conversation in
                        NavigationLink {
                            ConversationView(viewModel: ConversationViewModel(userInfo: viewModel.returnGoodUser(user1: conversation.user1!, user2: conversation.user2!), conversationID: conversation.conversationID))
                        } label: {
                            ConversationCellView(name: viewModel.returnGoodName(user1: conversation.user1!, user2: conversation.user2!), imageURL: viewModel.returnGoodPicture(user1: conversation.user1!, user2: conversation.user2!))
                        }
                    })
                }
            }.background(Image(Constantes.background)
                            .resizable()
                            .ignoresSafeArea()
                            .scaledToFill()
                            .blur(radius: 3, opaque: true)
                            .opacity(0.90)
            )
            .onAppear {
                viewModel.fetchAllUserConversations()
            }
            .navigationBarHidden(true)
            .navigationBarTitle(Text(""))
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
