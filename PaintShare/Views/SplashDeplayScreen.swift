//
//  SplashDeplayScreen.swift
//  PaintShare
//
//  Created by Limeng Ruan on 6/10/21.
//

import SwiftUI

struct SplashDeplayScreen: View {
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image("splash")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
