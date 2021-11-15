//
//  ProfilView.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import SwiftUI

struct ProfilView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var type = "library"
    @StateObject var api = ApiService()
    private var allType = ["library", "wishlist"]
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person.circle")
                        .frame(width: 80, height: 80)
                        .background(Color.red)
                        .clipShape(Circle())
                        .padding([.leading, .trailing], 30)
                    VStack(alignment: .leading) {
                        Text("Adrien")
                            .padding([.bottom], 20)
                        Text("PEREA")
                    }
                    Spacer()
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("logout")
                        Image(systemName: "power.circle.fill")
                    }
                    .foregroundColor(Color.red)

                    Spacer()
                }
                Divider()
                HStack {
                    Text("Adress :")
                    Text("89340 VILLENEUVE LA GUYARD ET BLA BLA BLA BLA BLA ")
                        .multilineTextAlignment(.leading)
                }
                Picker("type", selection: $type) {
                    ForEach(allType, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                Spacer()
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 5) {
                        ForEach(type == "library" ? api.favorite : api.wish) { fav in
                            NavigationLink {
                                DetailsView(id: fav.id)
                            } label: {
                                GameCellView(game: fav, width: geo.size.width)
                            }
                            .foregroundColor(Color.black)
                        }
                    }
                    .padding()
                }
            }
            .onAppear {
                api.getFavorite(favoritesID: api.favoriteID)
                api.getWish(wishID: api.wishID)
            }
        }
            
    }
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView()
    }
}
