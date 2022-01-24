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
        let appearance: UITabBarAppearance = UITabBarAppearance()
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().backgroundColor = UIColor(Color.black)
    }
    
    var body: some View {
        TabView(selection: $selection) {
            Top50View()
                .tabItem {
                    Text(Constantes.tab1)
                    Image(systemName: Constantes.tab1Logo)
                }.tag(1)
            SearchView()
                .tabItem {
                    Text(Constantes.tab2)
                    Image(systemName: Constantes.tab2Logo)
                }.tag(2)
            MapView()
                .tabItem {
                    Text(Constantes.tab3)
                    Image(systemName: Constantes.tab3Logo)
                }.tag(3)
            ChatView()
                .tabItem {
                    Text(Constantes.tab4)
                    Image(systemName: Constantes.tab4Logo)
                }.tag(4)
            ProfilView()
                .tabItem {
                    Text(Constantes.tab5)
                    Image(systemName: Constantes.tab5Logo)
                }.tag(5)
        }
        .accentColor(.black)
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
            .previewLayout(.sizeThatFits)
    }
}
