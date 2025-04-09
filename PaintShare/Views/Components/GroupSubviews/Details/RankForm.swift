//
//  RankForm.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/23/21.
//

import SwiftUI
import LineSDK

struct RankForm: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var rankFormDataModel: RankFormDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var groupDetailInfoDataModel: GroupDetailInfoDataModel
    
    @EnvironmentObject var agreementDataModel: AgreementDataModel
    
    @EnvironmentObject var chatDataModel:ChatDataModel
    
//    @State private var select = false
//
//    @State private var selectWeightNumber:Int = -1
//
//    @State private var selectDateNumber:Int = -1
    
    var body: some View {
        ZStack{
        VStack {
            CommonHeader(title: "評価の入力", showBackButton: true, showHamburgerButton: false,onBackClick: {
                presentationMode.wrappedValue.dismiss()
                // groupDetailInfoDataModel.navigationTag = nil
            })
            ScrollView {
                VStack(spacing: 20) {
                    ZStack {
                        VStack {
                            Text("必ずお読みください")
                                .font(.bold16)
                                .foregroundColor(.mainText)
                                .padding(.bottom, 6)
                            Text("「評価の記入」は、本アプリをご利用されたユーザー様が本グループに関し て体験された“感想”を記入し、他のユーザー様がフレンド申請する際のグループを選ぶときに参考にしていただくことを目的としています。")
                                .font(.light10)
                                .foregroundColor(.mainText)
                                .lineLimit(nil)
                            HStack(spacing: 0) {
                                Text("「評価の記入」を利用される際は、「")
                                    .font(.light10)
                                    .foregroundColor(.mainText)
                                Text("利用規約")
                                    .font(.light10)
                                    .foregroundColor(.primary)
                                    .onTapGesture(perform: {
                                        agreementDataModel.fromRank = 1
                                    })
                                Text("」をよくお読みの上、")
                                    .font(.light10)
                                    .foregroundColor(.mainText)
                                Spacer()
                            }
                            
                            Text("ご利用ください。当社が利用規約に反すると判断した評価については、削除させていただく場合が ありますので、あらかじめご了承ください。")
                                .font(.light10)
                                .foregroundColor(.mainText)
                                .lineLimit(nil)
                            
                        }
                        .padding(.all, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(Color(hex: "f5f5f5"))
                        )
                    }
                    VStack(spacing: 2) {
                        HStack {
                            Text("評価の対象")
                                .font(.regular12)
                                .foregroundColor(.mainText)
                            Spacer()
                        }
                        HStack {
                            Text(rankFormDataModel.groupName)
                                .font(.medium20)
                                .foregroundColor(.mainText)
                            Spacer()
                        }
                    }
                    VStack(spacing: 17) {
                        HStack {
                            Text("3段階評価")
                                .font(.regular12)
                                .foregroundColor(.mainText)
                            Spacer()
                        }
                        HStack {
                            SelectableRankLabel(rank: 0, selectedRank: $rankFormDataModel.selectedRank)
                            SelectableRankLabel(rank: 1, selectedRank: $rankFormDataModel.selectedRank)
                            SelectableRankLabel(rank: 2, selectedRank: $rankFormDataModel.selectedRank)
                        }
                        if (!rankFormDataModel.selectedRankMessage.isEmpty) {
                            Text(rankFormDataModel.selectedRankMessage)
                                .fixedSize(horizontal: false, vertical: true)
                                .lineLimit(nil)
                                .font(.bold12)
                                .foregroundColor(.caution)
                        }
                    }
                    MultilineTextField(label: "評価コメント", placeholder: "", required: true, value: $rankFormDataModel.comment, validationMessage: rankFormDataModel.commentMessage)
                 // chat
                    
                    if(chatDataModel.navigationTag == 2){
                        HStack{
                            Image("survey")
                                .frame(width: 24, height: 24)
                            Text("購入した商品の以下の点についてお答えください")
                                .foregroundColor(Color(hex: "#545353"))
                                .font(.regular14)
                            Spacer()
                        }
                        .frame(height: 24)
                        .background(Color(hex: "#E9FCFF"))
                        .cornerRadius(12)
                        .padding(.top, 20)
                        VStack(spacing: 18){
                            HStack{
                                Text("表記の重量は正確でしたか？")
                                    .foregroundColor(Color(hex: "#545353"))
                                    .font(.regular14)
                                    .padding(.leading,10)
                                Spacer()
                            }
                            .underlineTextField()

                            // circle?circle.inset.filled
                            HStack(spacing:0){
                                Image(systemName:rankFormDataModel.selectWeightNumber == 0 ? "circle.inset.filled":"circle" )
                                    .foregroundColor(Color(hex:rankFormDataModel.selectWeightNumber == 0 ? "#56B8C4" :"#B2B2B2"))
                                    .onTapGesture {

                                        if rankFormDataModel.selectWeightNumber == 0 {
                                            rankFormDataModel.selectWeightNumber = -1
                                        }else{
                                            rankFormDataModel.selectWeightNumber = 0
                                        }
                                    }
                                Text("大変満足")
                                    .foregroundColor(Color(hex: "#545353"))
                                    .font(.regular14)
                                Spacer()
                            }
                            .padding(.top,-5)

                            HStack(spacing:0){
                                Image(systemName:rankFormDataModel.selectWeightNumber == 1 ? "circle.inset.filled":"circle" )
                                    .foregroundColor(Color(hex:rankFormDataModel.selectWeightNumber == 1 ? "#56B8C4" :"#B2B2B2"))
                                    .onTapGesture {
                                        // select.toggle()
                                        // selectNumber = select ? -1 : 1
                                        // selectNumber = 1
                                        if rankFormDataModel.selectWeightNumber == 1 {
                                            rankFormDataModel.selectWeightNumber = -1
                                        }else{
                                            rankFormDataModel.selectWeightNumber = 1
                                        }
                                    }
                                Text("満足")
                                    .foregroundColor(Color(hex: "#545353"))
                                    .font(.regular14)
                                Spacer()
                            }
                            HStack(spacing:0){
                                Image(systemName:rankFormDataModel.selectWeightNumber == 2 ? "circle.inset.filled":"circle" )
                                    .foregroundColor(Color(hex:rankFormDataModel.selectWeightNumber == 2 ? "#56B8C4" :"#B2B2B2"))
                                    .onTapGesture {
                                        // selectNumber = 2
                                        if rankFormDataModel.selectWeightNumber == 2 {
                                            rankFormDataModel.selectWeightNumber = -1
                                        }else{
                                            rankFormDataModel.selectWeightNumber = 2
                                        }
                                    }
                                Text("やや不満")
                                    .foregroundColor(Color(hex: "#545353"))
                                    .font(.regular14)
                                Spacer()
                            }
                            HStack(spacing:0){
                                Image(systemName:rankFormDataModel.selectWeightNumber == 3 ? "circle.inset.filled":"circle" )
                                    .foregroundColor(Color(hex:rankFormDataModel.selectWeightNumber == 3 ? "#56B8C4" :"#B2B2B2"))
                                    .onTapGesture {
                                        // selectNumber = 3
                                        if rankFormDataModel.selectWeightNumber == 3 {
                                            rankFormDataModel.selectWeightNumber = -1
                                        }else{
                                            rankFormDataModel.selectWeightNumber = 3
                                        }
                                    }
                                Text("不満")
                                    .foregroundColor(Color(hex: "#545353"))
                                    .font(.regular14)
                                Spacer()
                            }

                            HStack{
                                Text("納期は正確でしたか？")
                                    .foregroundColor(Color(hex: "#545353"))
                                    .font(.regular14)
                                    .padding(.leading,10)
                                //.frame(width: UIScreen.main.bounds.size.width - 60)
                                Spacer()
                            }
                            .underlineTextField()
                            .padding(.top,5)

                            HStack(spacing:0){
                                Image(systemName:rankFormDataModel.selectDateNumber == 0 ? "circle.inset.filled":"circle" )
                                    .foregroundColor(Color(hex:rankFormDataModel.selectDateNumber == 0 ? "#56B8C4" :"#B2B2B2"))
                                    .onTapGesture {
                                        if rankFormDataModel.selectDateNumber == 0 {
                                            rankFormDataModel.selectDateNumber = -1
                                        }else{
                                            rankFormDataModel.selectDateNumber = 0
                                        }
                                    }
                                Text("大変満足")
                                    .foregroundColor(Color(hex: "#545353"))
                                    .font(.regular14)
                                Spacer()
                            }
                            .padding(.top,-5)

                            HStack(spacing:0){
                                Image(systemName:rankFormDataModel.selectDateNumber == 1 ? "circle.inset.filled":"circle" )
                                    .foregroundColor(Color(hex:rankFormDataModel.selectDateNumber == 1 ? "#56B8C4" :"#B2B2B2"))
                                    .onTapGesture {
                                        if rankFormDataModel.selectDateNumber == 1 {
                                            rankFormDataModel.selectDateNumber = -1
                                        }else{
                                            rankFormDataModel.selectDateNumber = 1
                                        }
                                    }
                                Text("満足")
                                    .foregroundColor(Color(hex: "#545353"))
                                    .font(.regular14)
                                Spacer()
                            }
                            HStack(spacing:0){
                                Image(systemName:rankFormDataModel.selectDateNumber == 2 ? "circle.inset.filled":"circle" )
                                    .foregroundColor(Color(hex:rankFormDataModel.selectDateNumber == 2 ? "#56B8C4" :"#B2B2B2"))
                                    .onTapGesture {
                                        if rankFormDataModel.selectDateNumber == 2 {
                                            rankFormDataModel.selectDateNumber = -1
                                        }else{
                                            rankFormDataModel.selectDateNumber = 2
                                        }
                                    }
                                Text("やや不満")
                                    .foregroundColor(Color(hex: "#545353"))
                                    .font(.regular14)
                                Spacer()
                            }
                            HStack(spacing:0){
                                Image(systemName:rankFormDataModel.selectDateNumber == 3 ? "circle.inset.filled":"circle" )
                                    .foregroundColor(Color(hex:rankFormDataModel.selectDateNumber == 3 ? "#56B8C4" :"#B2B2B2"))
                                    .onTapGesture {
                                        if rankFormDataModel.selectDateNumber == 3 {
                                            rankFormDataModel.selectDateNumber = -1
                                        }else{
                                            rankFormDataModel.selectDateNumber = 3
                                        }
                                    }
                                Text("不満")
                                    .foregroundColor(Color(hex: "#545353"))
                                    .font(.regular14)
                                Spacer()
                            }

                        }
                        .frame(width: UIScreen.main.bounds.size.width - 40)
                        .padding(.top,-15)
                    }
                    
                    NavigationLink(
                        destination: Agreement(), tag: 1, selection: $agreementDataModel.fromRank) {
                            EmptyView()
                        }.isDetailLink(false)
                    CommonButton(text: "保存", width:  UIScreen.main.bounds.size.width - 40, height: 37, disabled: rankFormDataModel.selectedRank == nil, onClick: {
                        rankFormDataModel.saveReview(dialogsDataModel: dialogsDataModel, groupDetailInfoDataModel: groupDetailInfoDataModel,chatDataModel:chatDataModel)
                    })
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    Spacer()
                }
                .padding(.horizontal, 10)
            }
        }
            if(chatDataModel.navigationTag == 2){
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
    }
}
