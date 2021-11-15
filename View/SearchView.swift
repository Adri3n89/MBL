//
//  SearchView.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI

struct SearchView: View {
    
    @State var gameName: String = ""
    @StateObject var api = ApiService()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $gameName, prompt: Text("enter your game name here"))
                    .padding()
                    .border(.secondary, width: 2)
                    .padding()
                Button {
                    api.searchGameName(name: gameName.replacingOccurrences(of: " ", with: "_"))
                } label: {
                    Text("Search")
                }
                ScrollView {
                    ForEach(api.searchResult) { game in
                        NavigationLink {
                            DetailsView(id: game.id)
                        } label: {
                            Text("- \(game.name.value)")
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .foregroundColor(Color.black)
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
