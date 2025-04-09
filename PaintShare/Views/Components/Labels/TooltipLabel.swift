//
//  TooltipLabel.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/15/21.
//

import SwiftUI

struct TooltipLabel: View {
    var body: some View {
        Image(systemName: "questionmark.circle")
            .renderingMode(.template)
            .foregroundColor(.primary)
            .frame(width: 15, height: 15)
    }
}
