//
//  ImageModal.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/06/22.
//

import SwiftUI

struct ImageModal: View {
    
    @Binding var showModal: Bool
        
    var logoImage: UIImage? = Constants.imageHolderUIImage
    
    var body: some View {
        VStack {
            Image(uiImage: logoImage!)
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    self.showModal = false
                }
//                .frame(width: 303, height: 303)
//                .clipped()
        }
    }
}
