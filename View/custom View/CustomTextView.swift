//
//  CustomTextView.swift
//  MBL (iOS)
//
//  Created by Adrien PEREA on 18/01/2022.
//

import SwiftUI

struct CustomTextView: View {
    
    let color: Color
    let text: String
    let placeholder: String
    let buttonText: String
    @Binding var show: Bool
    
    var body: some View {
        Text(text)
            .padding(5)
            .background(Color.gray.opacity(0.8))
            .cornerRadius(10)
            .foregroundColor(color)
            .onTapGesture(perform: {
                show.toggle()
            })
            .sheet(isPresented: $show, content: {
                AlertTFView(placeholder: placeholder, buttonText: buttonText)
                    .background(BackgroundClearView())
            })
            .frame(maxHeight: 40)
    }
}
