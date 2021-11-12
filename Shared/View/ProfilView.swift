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
    private var allType = ["library", "wishlist"]
    
    // 1. Number of items will be display in row
       var columns: [GridItem] = [
           GridItem(.flexible()),
           GridItem(.flexible())
       ]
       // 2. Fixed height of card
       let height: CGFloat = 150
       // 3. Get mock cards data
       let cards: [Card] = MockStore.cards
    
    var body: some View {
        ScrollView {
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
                LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(cards) { card in
                                    CardView(title: card.title)
                                        .frame(height: height)
                                }
                            }
                            .padding()
            }
        }
    }
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView()
    }
}
