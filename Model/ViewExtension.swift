//
//  Extensions.swift
//  MGL (iOS)
//
//  Created by Adrien PEREA on 22/11/2021.
//

import Foundation
import SwiftUI

extension View {
    
    func glowBorder(color: Color, lineWidth: Int) -> some View {
        self.modifier(GlowBorder(color: color, lineWidth: lineWidth))
    }
    
}
