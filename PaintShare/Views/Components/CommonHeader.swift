//
//  CommonHeader.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/8/21.
//

import SwiftUI

struct CommonHeader: View {
    
    var title: String
    
    var showBackButton: Bool = false
    
    var showHamburgerButton: Bool = true
    
    var showBlockButton: Bool = false
    
    var showReportButton: Bool = false
    
    var onBackClick: () -> Void = {}
    
    var showSearch: Bool = false
    
    var showClose: Bool = false
    
    var onSearchClick: () -> Void = {}
    
    var onCloseClick: () -> Void = {}
    
    var numberMark: Int = 0
    
    @EnvironmentObject var hamburgerMenuDataModel:HamburgerMenuDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var inquiryFromDataModel:InquiryFromDataModel
    
    @EnvironmentObject var chatDataModel:ChatDataModel
    
    @EnvironmentObject var mainViewDataModel: MainViewDataModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(height: 46)
                .shadow(color: Color(hex: "000000").opacity(0.1), radius: 1, x: 0.0, y: 2)
            Text(title)
                .font(.bold16)
                .foregroundColor(.secondary)
            
            if(showHamburgerButton){
                HStack {
                    Spacer()
                    if dialogsDataModel.showOverPriceBtn == true {
                        ZStack{
                            GeneralButton(onClick: {
                                dialogsDataModel.mainViewNavigationTag = 28
                            }, label: {
                                Image("over-price")
                            })
                        }.padding(.bottom, 5)
                    }
                    ZStack {
                        Image(systemName: "text.justify")//
                            .font(.regular20)
                            .foregroundColor(Color(hex:"#56B8C4"))
                            .onTapGesture {
                                if(!mainViewDataModel.tabDisabled){
                                    hamburgerMenuDataModel.show = true
                                    hamburgerMenuDataModel.reset()
                                    dialogsDataModel.UnreadMessage = 0
                                }else{
                                    mainViewDataModel.showAccountNotFinishedDialog = true
                                }
                        }
                       // if (numberMark != 0) {
                        if (dialogsDataModel.UnreadMessage != 0) {
//                        if (hamburgerMenuDataModel.userUnreadMessage == 1 || hamburgerMenuDataModel.ownerUnreadMessage == 1) {
                       // if  (UIApplication.shared.applicationIconBadgeNumber != 0){
                            
            //                if (numberMark > 9) {
            //                    Text("9+")
            //                        .font(.regular10)
            //                        .foregroundColor(.white)
            //                        .background(
                                        Circle()
                                            .fill(Color(hex: "f16161"))
                                            .frame(width: 13, height: 13)
                                            .offset(x: 9, y: -9)
                            }
                    }
                }
                .padding(.trailing,22)
            }
            
            if(showBlockButton){
                HStack {
                    Spacer()
                    VStack(spacing: 0){
                        Image(systemName: "nosign")
                            .font(.regular20)
                            .foregroundColor(Color(hex:"#56B8C4"))
                            .frame(width: 15, height: 15)
                        
                        Text("ブロック")
                            .font(.regular12)
                            .foregroundColor(Color(hex:"#56B8C4"))
                    }
                    .onTapGesture {
                        
                    }
                }
                .padding(.trailing,65)
            }
            
            if(showReportButton){
                HStack {
                    Spacer()
                    VStack(spacing: 0){
                        Image(systemName: "pencil")
                            .font(.regular20)
                            .foregroundColor(Color(hex:"#56B8C4"))
                            .frame(width: 15, height: 15)
                        Text("通報")
                            .font(.regular12)
                            .foregroundColor(Color(hex:"#56B8C4"))
                    }
                    .onTapGesture {
                        chatDataModel.navigationTag = 1
                          inquiryFromDataModel.rest()
                    }
                }
                .padding(.trailing,22)
            }
            
            if (showBackButton) {
                HStack {
                    Image("back-chevron")
                        .resizable()
                        .frame(width: 10, height: 15.26)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .contentShape(RoundedRectangle(cornerRadius: 0))
                        .onTapGesture {
                            onBackClick()
                        }
                    Spacer()
                }
            }
            if showSearch {
                HStack{
                    Spacer()
                    GeneralButton(onClick: {
                        onSearchClick()
                    }, label: {
                        Image("magnifiying-glass")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.secondary)
                            .padding(.trailing, 25)
                    })
                }
            }
            if showClose {
                HStack{
                    Spacer()
                    GeneralButton(onClick: {
                        onCloseClick()
                    }, label: {
                        Image("close")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(Color(hex: "545353"))
                            .padding(.trailing, 25)
                    })
                }
            }
        }
        .frame(height: 46)
        
    }
}
