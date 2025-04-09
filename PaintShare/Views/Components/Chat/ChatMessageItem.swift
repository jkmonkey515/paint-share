//
//  ChatMessageItem.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/06/21.
//

import SwiftUI

struct ChatMessageItem: View {
    
    @EnvironmentObject var chatDataModel:ChatDataModel
    
    @EnvironmentObject var mainViewDataModel:MainViewDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    var message:MessageDto
    
    var googleMapLine: String="https://www.google.com/maps/search/?api=1"
    
    var body: some View {
        
        if (message.messageSender.id == mainViewDataModel.loggedInUserId){
            HStack {
                Spacer()
                
                VStack {
                    Spacer()
                    Text(message.readStatus == 1 ? "既読":"")
                        .font(.regular10)
                        .foregroundColor(Color(hex: "#8E8E8E"))
                        .padding(.leading,0)
                    Text(DateTimeUtils.timestampToStrHourMinute(timestamp: message.createdAt))
                        .font(.regular10)
                        .foregroundColor(Color(hex: "#8E8E8E")).padding(.leading,0)
                }
                .padding(.leading,100)
              
                if(message.type==0){
                Text(message.text)
                    .font(.regular14)
                    .foregroundColor(Color(hex: "#545353"))
                    .padding(8)
                    .background(Color(hex: "#A3E8F1"))
                    .cornerRadius(5)
                }else if(message.type==1){
                    ImageView(withURL: UrlConstants.IMAGE_S3_ROOT + message.text, aspectRatio: .fit, onClick: {
                        img in
                        dialogsDataModel.largeImage = img
                        dialogsDataModel.showLargeImage=true
                    })
                        .frame(width:130,height:130)
                        .clipped()
//                        .cornerRadius(5)
//                        .padding(.trailing,0)
                    
                }else if(message.type==2){
                    ZStack{
                    HStack(spacing:0){
                        Text("位置 ")
                            .font(.regular14)
                                .foregroundColor(Color(hex: "#545353"))
                        Link(destination:URL( string: googleMapLine+"&query=\(message.text)")!){
                            Image(systemName: "link.circle.fill")
                                .font(.regular20)
                        }
                    }
                    .padding(8)
                    }
                    .background(Color(hex: "#A3E8F1"))
                    .cornerRadius(5)
                    
                }
                
            }
            .padding(.trailing,20)
            
        }else{
            HStack {
                VStack {
                    Image(uiImage: chatDataModel.chatUserLogo!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 33, height: 33)
                        .clipped()
                    Spacer()
                }
                if(message.type==0){
                Text(message.text)
                    .font(.regular14)
                    .foregroundColor(Color(hex: "#545353"))
                    .padding(8)
                    .background(Color(hex: "#E0E0E0"))
                    .cornerRadius(5)
                }else if(message.type==1){
                    ImageView(withURL: UrlConstants.IMAGE_S3_ROOT + message.text, aspectRatio: .fit, onClick: {
                      img in
                      dialogsDataModel.largeImage = img
                      dialogsDataModel.showLargeImage=true
                  })
                        .frame(width:130,height:130)
                        .clipped()
//                        .cornerRadius(5)
//                        .padding(.leading,0)
                    
                }else if(message.type==2){
                    ZStack{
                    HStack(spacing:0){
                        Text("位置 ")
                            .font(.regular14)
                                .foregroundColor(Color(hex: "#545353"))
                        Link(destination:URL( string: googleMapLine+"&query=\(message.text)")!){
                            Image(systemName: "link.circle.fill")
                                .font(.regular20)
                        }
                    }
                    .padding(8)
                    }
                    .background(Color(hex: "#E0E0E0"))
                    .cornerRadius(5)
                }
                
                VStack {
                    Spacer()
                    Text(DateTimeUtils.timestampToStrHourMinute(timestamp: message.createdAt))
                        .font(.regular10)
                        .foregroundColor(Color(hex: "#8E8E8E")).padding(.leading,0)
                }
                .padding(.trailing,60)
                Spacer()
            }
            .padding(.leading,20)
        }
    }
}
