//
//  ImageView.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/08/15.
//

import SwiftUI

struct ImageView: View {
    @EnvironmentObject var chatDataModel:ChatDataModel
    
    @ObservedObject var imageLoader:ImageLoader
    
    @State var image:UIImage = Constants.imageHolderUIImage!
    //Constants.imageHolderUIImage!
    
    var aspectRatio: ContentMode
    
    var onClick: (_: UIImage) -> Void
    
    init(withURL url:String, aspectRatio: ContentMode = .fill, onClick: @escaping (_: UIImage) -> Void) {
        imageLoader = ImageLoader(urlString:url)
        self.aspectRatio = aspectRatio
        self.onClick = onClick
    }
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: aspectRatio)
            .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
            }
            .onTapGesture {
                self.onClick(self.image)
            }
    }
}
