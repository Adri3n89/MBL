//
//  CustomTabView.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI

struct CustomTabView: View {
    @State var selection = 1
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.black
    }
    
    var body: some View {
        TabView(selection: $selection) {
            Top50View()
                .tabItem {
                Text("Top 50")
                Image(systemName: "arrow.up.square.fill")
            }.tag(1)
            SearchView()
                .tabItem {
                Text("Search")
                Image(systemName: "magnifyingglass")
            }.tag(2)
            MapView()
                .tabItem {
                Text("Map")
                Image(systemName: "globe")
            }.tag(3)
            ChatView()
                .tabItem {
                Text("Chat")
                Image(systemName: "message")
            }.tag(4)
            ProfilView()
                .tabItem {
                Text("Profil")
                Image(systemName: "person")
            }.tag(5)
        }.tint(.gray)
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
            .previewLayout(.sizeThatFits)
    }
}
