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
        GeometryReader { geo in
            NavigationView {
                ScrollView {
                    if viewModel.allConversationsDate.count == 0 {
                        VStack {
                            HStack(alignment: .center) {
                                Spacer()
                                Text(Constantes.noConversation)
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .frame(height: geo.size.height)
                                Spacer()
                            }
                        }
                    } else {
                        ForEach(viewModel.allConversationsDate, content: { conversation in
                            NavigationLink {
                                ConversationView(viewModel: ConversationViewModel(userInfo: viewModel.returnGoodUser(conversation, userID: viewModel.conversationRepo.currentUserID!), conversationID: conversation.conversationID))
                            } label: {
                                ConversationCellView(name: viewModel.returnGoodName(conversation, userID: viewModel.conversationRepo.currentUserID!), imageURL: viewModel.returnGoodPicture(conversation, userID: viewModel.conversationRepo.currentUserID!), lastMessage: conversation.messages?.last?.text ?? "No Message")
                            }
                        })
                    }
                }
                .background(BackgroundView())
                .onAppear {
                    viewModel.fetchAllUserConversations()
                }
                .navigationBarHidden(true)
                .navigationBarTitle(Text(""))
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
