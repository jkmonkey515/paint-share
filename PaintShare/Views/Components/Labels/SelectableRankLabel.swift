//
//  RankLabelWithSelection.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/23/21.
//

import SwiftUI

struct SelectableRankLabel: View {
    
    var rank: Int
    
    @Binding var selectedRank: Int?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.primary, lineWidth: 3)
                .frame(width: 104, height: 32)
                .opacity(selectedRank == rank ? 1 : 0)
            RankLabel(rank: rank)
        }
        .onTapGesture {
            if selectedRank == rank {
                selectedRank = nil
            } else {
                selectedRank = rank
            }
        }
    }
}
