//
//  RequestForm.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/26/21.
//

import SwiftUI

struct RequestForm: View {
    
    @EnvironmentObject var requestFormDataModel: RequestFormDataModel
    
    @EnvironmentObject var groupSearchDataModel: GroupSearchDataModel
    
    @EnvironmentObject var agreementDataModel: AgreementDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    var from: Int = 0
    
    var body: some View {
        ZStack{
        VStack(spacing: 0) {
            CommonHeader(title: requestFormDataModel.isJoin ? "メンバー申請" : "フレンド申請", showBackButton: true, onBackClick: {
                self.groupSearchDataModel.navigationTag = nil
            })
            ScrollView {
                VStack(spacing: 0) {
                    OvalLabel(text: requestFormDataModel.isJoin ? "メンバー申請" : "フレンド申請", width: 114, height: 27, bgColor: requestFormDataModel.isJoin ? Color(hex: "1db78b") : Color(hex: "1e94fa"), font: .bold12)
                        .padding(.top, 19)
                    ImageView(withURL: requestFormDataModel.groupSearchItem.groupDto.groupImgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + requestFormDataModel.groupSearchItem.groupDto.groupImgKey!, onClick: {
                        img in
                    }).frame(width: 93, height: 93)
                        .clipped()
                        .padding(.top, 7)
                    HStack {
                        Text("申請先グループ")
                            .font(.regular12)
                            .foregroundColor(.mainText)
                        Spacer()
                    }
                    .padding(.top, 14)
                    HStack {
                        Text("ID：\(requestFormDataModel.groupSearchItem.groupDto.generatedGroupId)")
                            .font(.regular12)
                            .foregroundColor(.mainText)
                        Spacer()
                    }
                    .padding(.top, 3)
                    HStack {
                        Text(requestFormDataModel.groupSearchItem.groupDto.groupName)
                            .font(.medium20)
                            .foregroundColor(.mainText)
                        Spacer()
                    }
                    MultilineTextField(label: "メッセージ", placeholder: "", required: true, value: $requestFormDataModel.requestMessage, validationMessage: requestFormDataModel.requestMessageMessage)
                        .padding(.top, 24)
                    HStack(spacing: 0) {
                        Text("「")
                            .font(.light10)
                            .foregroundColor(.mainText)
                        Text("利用規約")
                            .font(.light10)
                            .foregroundColor(.primary)
                            .onTapGesture(perform: {
                                requestFormDataModel.needNotAppearRefresh = true
                                agreementDataModel.fromRequest = 1
                            })
//                        Text("」や「")
//                            .font(.light10)
//                            .foregroundColor(.mainText)
//                        Text("投稿ガイドライン")
//                            .font(.light10)
//                            .foregroundColor(.primary)
                        Text("」に違反しないよう心がけましょう。")
                            .font(.light10)
                            .foregroundColor(.mainText)
                    }
                    .padding(.top, 60)
                    NavigationLink(
                        destination: Agreement(), tag: 1, selection: $agreementDataModel.fromRequest) {
                        EmptyView()
                    }.isDetailLink(false)
                    CommonButton(text: requestFormDataModel.isJoin ? "メンバー申請をする" : "フレンド申請をする", width:  UIScreen.main.bounds.size.width - 40, height: 37, onClick: {
                        requestFormDataModel.showConfirm()
                    })
                        .padding(.top, 30)
                        .padding(.bottom, 160)
                    Spacer()
                }
                .padding(.horizontal, 10)
            }
        }
            if from == 2{
            MainViewModals()
                if (dialogsDataModel.showLoading) {
                    ProgressView()
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            hideKeyboard()
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            if requestFormDataModel.needNotAppearRefresh == false {
                requestFormDataModel.requestMessage = requestFormDataModel.isJoin ? "はじめまして、申請の承認をお願いします。" : "はじめまして、申請の承認をお願いします。"
            }else{
                requestFormDataModel.needNotAppearRefresh = false
            }
        })
    }
}
