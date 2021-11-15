//
//  Card.swift
//  MGL
//
//  Created by Adrien PEREA on 01/11/2021.
//

import Foundation
import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    let title: String
}

struct RowView: View {
    let cards: [Card]
    let width: CGFloat
    let height: CGFloat
    let horizontalSpacing: CGFloat
    var body: some View {
        HStack(spacing: horizontalSpacing) {
            ForEach(cards) { card in
                CardView(title: card.title)
                    .frame(width: width, height: height)
            }
        }
        .padding()
    }
}
