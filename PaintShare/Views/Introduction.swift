//
//  Introduction.swift
//  PaintShare
//
//  Created by JUNTAO YE on 2021/04/22.
//

import SwiftUI

struct Introduction: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var mainViewDataModel: MainViewDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var groupManagementDataModel: GroupManagementDataModel
    
    var body: some View {
        ScrollView {
            ZStack{
                VStack{
                    Image("firstime-bg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 1.1)
                        .blur(radius: 2.0)
                        .offset(y: -35)
                    Spacer()
                    Image("register-footer-img")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 1.2)
                }
                .frame(maxWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.height)
                VStack{
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color(.white).opacity(0.6))
                            .frame(width: UIScreen.main.bounds.width - 30, height: 65)
                            .shadow(color: Color(.black).opacity(0.16), radius: 3, x: 0, y: 3)
                        Text("初回の設定")
                            .font(.bold27)
                            .foregroundColor(.mainText)
                    }
                    .padding(.top, 114)
                    VStack(spacing: 10){
                        Text("グループへ参加")
                            .shadow(color: Color(.black).opacity(0.7), radius: 5, x: 0, y: 3)
                        Text("または")
                            .shadow(color: Color(.black).opacity(0.7), radius: 5, x: 0, y: 3)
                        Text("グループを作成してください")
                            .shadow(color: Color(.black).opacity(0.7), radius: 5, x: 0, y: 3)
                    }
                    .font(.regular20)
                    .foregroundColor(.white)
                    .padding(.top, 23)
                    OvalButton(text: "グループを検索", onClick:
                                {
                                    groupManagementDataModel.selectedTab = 0
                                    mainViewDataModel.selectedTab = 0
                                    presentationMode.wrappedValue.dismiss()
                                })
                        .padding(.top, 33)
                    OvalButton(text: "グループを作成", onClick:
                                {
                                    groupManagementDataModel.selectedTab = 4
                                    mainViewDataModel.selectedTab = 0
                                    presentationMode.wrappedValue.dismiss()
                                })
                        .padding(.top, 15)
                    Text("当アプリのご利用を開始するためには、下記いずれかの設定が必要となります。")
                        .multilineTextAlignment(.leading)
                        .font(.regular14)
                        .foregroundColor(.mainText)
                        .padding(.top, 46)
                        .padding(.horizontal, 15)
                    VStack(spacing: 5){
                        Text("所属グループを検索し、グループへの参加依頼")
                            .underline();
                        Text("または、")
                            .font(.regular14)
                        Text("ご自身がオーナーの場合、グループを新規作成")
                            .underline()
                    }
                    .font(.bold14)
                    .foregroundColor(.mainText)
                    .padding(.top, 4)
                    HStack{
                        Text("早速、設定をして塗料在庫シェアをはじめましょう！")
                        Spacer()
                    }
                    .font(.regular14)
                    .foregroundColor(.mainText)
                    .padding(.top, 12)
                    .padding(.horizontal, 15)
                    .padding(.bottom, 120)
                    Spacer()
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
