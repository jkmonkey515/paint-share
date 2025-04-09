//
//  MessageInputView.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/21.
//

import SwiftUI

struct MessageInputView: View {
    
    @EnvironmentObject var chatDataModel:ChatDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var mapSearchDataModel:MapSearchDataModel
    
    @EnvironmentObject var mainViewDataModel:MainViewDataModel
    
    var body: some View {
        ZStack{
            Color(hex: "#F1F1F1")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing:0){
                
                HStack {
                    MultilineTextField(label: "", placeholder: "",height: 38,value: $chatDataModel.chatText)
                }
                .background(Color.white)
                .cornerRadius(5)
                .padding(10)
                
//                HStack {
//                    Spacer()
//                    Text("口座情報の入力不可対応")
//                        .font(.light10)
//                        .foregroundColor(Color(hex: "#707070"))
//                        .padding(.trailing,10)
//                }
//                .padding(.top,-8)
                
                HStack {
                    Image(systemName: "camera.fill")
                        .foregroundColor(Color(hex: "#56B8C4"))
                        .font(Font.system(size: 28))
                        .padding(.leading,15)
                        .onTapGesture(perform: {
                            chatDataModel.shouldPresentImagePicker = true
                            chatDataModel.shouldPresentCamera = true
                            hideKeyboard()
                        })
                    Image(systemName: "photo")
                        .foregroundColor(Color(hex: "#56B8C4"))
                                .font(Font.system(size: 28))
                                .padding(.leading,5)
                                .onTapGesture(perform: {
                                    chatDataModel.shouldPresentImagePicker = true
                                    chatDataModel.shouldPresentCamera = false
                                    hideKeyboard()
                                })
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(Color(hex: "#56B8C4"))
                                        .font(Font.system(size: 28))
                                        .padding(.leading,5)
                                        .onTapGesture(perform: {
                                            mapSearchDataModel.searchPhrase = ""
                                            chatDataModel.shouldMappin = true
                                            chatDataModel.subwindowTag = 2
                                            hideKeyboard()
                                        })
                    Spacer()
                    GeneralButton(onClick: {
                        chatDataModel.sendChatMessage(mainViewDataModel:  mainViewDataModel,type:0,content: chatDataModel.chatText,dialogsDataModel: dialogsDataModel)
                    }, label: {
                        Text("送信")
                            .font(.regular14)
                            .foregroundColor(.white)
                            .frame(width: 75,height: 35)
                    })
                        .background(Color(hex: "#1DB78B"))
                        .cornerRadius(5)
                        .shadow(color: Color(hex: "000000").opacity(0.1), radius: 1, x: 0.0, y: 2)
                        .padding(.trailing,10)
                }
                .padding(.top,5)
                Spacer()
            }
        }
        .frame(height: 135)
    }
}
