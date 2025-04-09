//
//  ImageEditor.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/15/21.
//

import SwiftUI

struct ImageEditor: View {
    
    var title: String
    
    @Binding var img: UIImage?
    
    @Binding var showImagePicker: Bool
    
    var imgHolder: UIImage = Constants.imageHolderUIImage!
    
    var imageDeleteSubject: String
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    var from: Int = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            HStack{
                Text(title)
                    .font(.regular12)
                    .foregroundColor(.mainText)
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(hex: "c5c5c5"))
                        .frame(width: 44, height: 21)
                    Text("任意")
                        .font(.regular11)
                        .foregroundColor(.white)
                }.padding(.leading, 10)
            }
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 3) {
                    Image(uiImage: img!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        .clipped()
                }
                CommonButton(text: img == imgHolder ? "登録" : "変更", width: 100, height: 28, onClick: {
                    if from != 1{
                        self.showImagePicker = true
                    }
                })
                CommonButton(text: "削除", color: .secondary, width: 100, height: 28, disabled: img == imgHolder, onClick: {
                    //img = imgHolder
                    if from != 1{
                        dialogsDataModel.imageDeleteSubject = imageDeleteSubject
                        dialogsDataModel.imageDeleteDialog = true
                    }
                })
            }
        }
    }
}
