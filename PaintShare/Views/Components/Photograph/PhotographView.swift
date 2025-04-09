//
//  PhotographView.swift
//  PaintShare
//
//  Created by Lee on 2022/7/5.
//

import SwiftUI

struct PhotographView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var navigationTag: Int? = nil
    
    @EnvironmentObject var photographViewDataModel: PhotographViewDataModel
    
    @EnvironmentObject var memberCancelDataModel: MemberCancelDataModel
        
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var mainViewDataModel: MainViewDataModel
    
    var body: some View {
        VStack{
            CommonHeader(title: "画像認識利用状況管理", showBackButton: true, showHamburgerButton:false, onBackClick: {
                photographViewDataModel.changeImageStatus(id: mainViewDataModel.loggedInUserGroup?.id ?? 0, dialogsDataModel: dialogsDataModel)
                photographViewDataModel.navigationTag = nil
                self.presentationMode.wrappedValue.dismiss()
            })
            HStack(spacing: 60){
                HStack{
                    VStack(alignment: HorizontalAlignment.center){
                        Text("合計利用回数")
                            .font(.medium16)
                            .padding(.top, 30)
                        ZStack{
                            Circle()
                                .frame(width: 74, height: 74)
                                .foregroundColor(Color(hex: "#A3E8F1"))
                            Text("\(photographViewDataModel.totalUseCount)")
                                .font(.bold27)
                        }
                    }
                    Text("回")
                        .font(.bold20)
                        .padding(.top, 100)
                }
                HStack{
                    VStack(alignment: HorizontalAlignment.center){
                        Text("残回数")
                            .font(.medium16)
                            .padding(.top, 30)
                        ZStack{
                            Circle()
                                .frame(width: 74, height: 74)
                                .foregroundColor(Color(hex: "#FCE2A9"))
                            Text("\(photographViewDataModel.remainUseCount)")
                                .font(.bold27)
                        }
                    }
                    Text("回")
                        .font(.bold20)
                        .padding(.top, 100)
                }
            }
            CommonTextField(label: "超過金額", placeholder: "", color: Color(hex: "#F16161"), value: $photographViewDataModel.overPirce, disabled: true)
                .padding(.top, 15)
                .padding(.horizontal, 21)
            
            if photographViewDataModel.prevMonthImgPrice > 0 {
                HStack{
                    Text("前月からの持ち越し分：￥" + String(photographViewDataModel.prevMonthImgPrice))
                        .font(.regular12)
                        .foregroundColor(Color(hex: "#545353"))
                    Spacer()
                }
                .padding(.horizontal, 21)
                .padding(.bottom, 10)
            }
            
            HStack{
                Text("1枚毎10円(税込)が加算されます")
                    .font(.regular12)
                    .foregroundColor(Color(hex: "#8E8E8E"))
                Spacer()
            }.padding(.horizontal, 21)
            
            HStack{
                Text("カード金額不足や他の原因で支払い失敗、または超過金額が\n￥40以下の場合は次月に持ち越しされます")
                    .font(.regular12)
                    .foregroundColor(Color(hex: "#8E8E8E"))
                Spacer()
            }.padding(.horizontal, 21)
            
            Toggle(isOn: $photographViewDataModel.permit, label: {
                HStack(spacing: 15) {
                    Text("画像認識の利用可否設定")
                        .font(.bold16)
                        .foregroundColor(.mainText)
                }
            }).onTapGesture(perform: {
                
            })
            .padding(.top, 20)
            .padding(.bottom, 15)
            .underlineTextField()
            .padding(.horizontal, 21)
            
            HStack{
                Text("メンバー別利用回数一覧")
                    .font(.medium16)
                    .foregroundColor(Color(hex: "#46747E"))
                Spacer()
            }
            .padding(.top, 30)
            .padding(.horizontal, 21)
            ScrollView {
                ForEach(0 ..< photographViewDataModel.groupImageUseDtoList.count, id: \.self) {
                    i in
                    PhotographItem(memberListItem: photographViewDataModel.groupImageUseDtoList[i], type:1)
                        .underlineListItem()
                }
            }
            
            Spacer()
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            photographViewDataModel.getListData(id: mainViewDataModel.loggedInUserGroup?.id ?? 0, dialogsDataModel: dialogsDataModel)
        }
    }
}
