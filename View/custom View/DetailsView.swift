//
//  DetailsView.swift
//  MGL
//
//  Created by Adrien PEREA on 14/11/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailsView: View {
    
    @StateObject var api = ApiService()
    @State var id: String?
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            ScrollView {
                VStack(alignment: .center) {
                    HStack {
                        Spacer()
                        WebImage(url: URL(string: api.gameInfo?.image ?? "https://www.google.com/imgres?imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2Fa%2Fac%2FNo_image_available.svg%2F1024px-No_image_available.svg.png&imgrefurl=https%3A%2F%2Ffr.wikipedia.org%2Fwiki%2FFichier%3ANo_image_available.svg&tbnid=-QpL1I7u3zbiBM&vet=12ahUKEwiOoerLmJj0AhWX0oUKHQBnDZIQMygAegUIARCzAQ..i&docid=aAMqfi5Qgc7s4M&w=1024&h=1024&q=no%20image&ved=2ahUKEwiOoerLmJj0AhWX0oUKHQBnDZIQMygAegUIARCzAQ"))
                            .resizable()
                            .scaledToFit()
                            .clipped()
                            .frame(width: width/2, height: width/2, alignment: .center)
                        Spacer()
                    }
                    VStack {
                        Text("Year : \(api.gameInfo?.yearpublished.value ?? "?")")
                        Text("Players : \(api.gameInfo?.minplayers.value ?? "") - \(api.gameInfo?.maxplayers.value ?? "")")
                        Text("Estimate play time : \(api.gameInfo?.minplaytime.value ?? "") - \(api.gameInfo?.maxplaytime.value ?? "")")
                    }.padding()
                    HStack {
                        Spacer()
                        Button {
                            // ajouter a la bibliotèque
                        } label: {
                            Text("Add to library ✅")
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("Add to wish-list 🙏🏻")
                        }
                        Spacer()
                    }
                    Divider()
                    Text(api.gameInfo?.itemDescription.decodingUnicodeCharacters.replacingOccurrences(of: "&mdash;", with: "-") ?? "no description")
                        .padding()
                }
            }
            .onAppear {
                api.gameInfo = nil
                api.getGameByID(id: id!)
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(api: ApiService())
    }
}
