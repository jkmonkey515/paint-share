//
//  MainTabButton.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/8/21.
//

import SwiftUI

struct MainTabButton: View {
    
    var iconName: String
    
    var label: String
    
    var body: some View {
        VStack(spacing: 2) {
            Image(iconName)
                .renderingMode(.template)
            Text(label)
                .font(.regular10)
        }
    }
}
