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
                    if viewModel.allConversations.count == 0 {
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
                        ForEach(viewModel.allConversations, content: { conversation in
                            NavigationLink {
                                ConversationView(viewModel: ConversationViewModel(userInfo: viewModel.returnGoodUser(conversation), conversationID: conversation.conversationID))
                            } label: {
                                ConversationCellView(name: viewModel.returnGoodName(conversation), imageURL: viewModel.returnGoodPicture(conversation))
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
