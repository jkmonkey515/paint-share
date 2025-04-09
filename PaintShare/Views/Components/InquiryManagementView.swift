//
//  InquiryManagementView.swift
//  PaintShare
//
//  Created by Kaetsu Jo on 2022/07/06.
//

import SwiftUI

struct InquiryManagementView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var inquiryManagementDataModel:InquiryManagementDataModel
    
    @EnvironmentObject var inquiryUserDataModel:InquiryUserDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel

    var body: some View {
            VStack(spacing:0){
//                CommonHeader(title: "お問い合わせ管理", showBackButton: true, showHamburgerButton: false,onBackClick: {
//                    presentationMode.wrappedValue.dismiss()
//                })
                ScrollView{
                VStack(spacing:0) {
                    
                    ForEach(inquiryManagementDataModel.chatroomDistinctListItems,id:\.self){
                        item in
                        InquiryManagementListItem(chatroomDistinctListItem: item,numberMark: item.chatroomDistinctDto.readStatus ?? 1)
                            .onTapGesture {
                                inquiryUserDataModel.reset()
                                inquiryUserDataModel.inventoryDto=item.chatroomDistinctDto.paint
                                inquiryUserDataModel.imgKey=item.chatroomDistinctDto.paint.materialImgKey
                                inquiryUserDataModel.paintId = item.chatroomDistinctDto.paint.id
                                inquiryUserDataModel.getOwnerChatroomList(dialogsDataModel: dialogsDataModel)
                                inquiryManagementDataModel.navigationTag = 1
                            }
                    }
                }.padding(.top,15)
                Spacer()
                NavigationLink(
                    destination: InquiryUserView(), tag: 1, selection: $inquiryManagementDataModel.navigationTag) {
                        EmptyView()
                    }.isDetailLink(false)
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
            .onAppear(perform: {
                inquiryManagementDataModel.getChatroomDistinctList(dialogsDataModel: dialogsDataModel)
            })
    }
}
