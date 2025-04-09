//
//  GroupDetailInfo.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/22/21.
//

import SwiftUI

struct GroupDetailInfo: View {
    
    //@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var groupDetailInfoDataModel: GroupDetailInfoDataModel
    
    @EnvironmentObject var rankFormDataModel: RankFormDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var groupSearchDataModel: GroupSearchDataModel
    
    @EnvironmentObject var allRanksDataModel: AllRanksDataModel
    
    @EnvironmentObject var mainViewDataModel: MainViewDataModel
    
    var body: some View {
        VStack {
            CommonHeader(title: "グループ詳細情報", showBackButton: true, onBackClick: {
                groupSearchDataModel.navigationTag = nil
            })
            ScrollView {
                VStack(spacing: 20) {
                    ImageView(withURL: groupDetailInfoDataModel.groupSearchItem.groupDto.groupImgKey == nil ? "" : UrlConstants.IMAGE_S3_ROOT + groupDetailInfoDataModel.groupSearchItem.groupDto.groupImgKey!, onClick: {
                        img in
                    }).frame(width:111,height:111)
                        .clipped()
                    CommonTextField(label: "グループ名", placeholder: "", value: $groupDetailInfoDataModel.groupSearchItem.groupDto.groupName, disabled: true)
                    CommonTextField(label: "グループオーナー", placeholder: "", value: $groupDetailInfoDataModel.fullName, disabled: true)
                    if groupDetailInfoDataModel.showPhoneNumber {
                        CommonTextField(label: "電話番号", placeholder: "", value: $groupDetailInfoDataModel.groupSearchItem.groupDto.phone, disabled: true)
                    }
                    MultilineTextField(label: "グループの説明", placeholder: "", value: $groupDetailInfoDataModel.groupSearchItem.groupDto.description, disabled: true)
                    HStack {
                        Text("みんなの評価")
                            .font(.regular12)
                            .foregroundColor(.mainText)
                        Spacer()
                        RankCountsLabel(rank0Count: groupDetailInfoDataModel.groupSearchItem.rank0Count, rank1Count: groupDetailInfoDataModel.groupSearchItem.rank1Count, rank2Count: groupDetailInfoDataModel.groupSearchItem.rank2Count, imageSize: 25, font: .medium16, textWidth: 32)
                        Spacer()
                        NavigationLink(
                            destination: AllRanks().onDisappear(perform: {
                                groupDetailInfoDataModel.getGroupSearchDto(dialogsDataModel: dialogsDataModel, mainViewDataModel: mainViewDataModel)
                            }), tag: 2, selection: $groupDetailInfoDataModel.navigationTag) {
                            EmptyView()
                        }.isDetailLink(false)
                        Image(systemName: "chevron.right")
                            .renderingMode(/*@START_MENU_TOKEN@*/.template/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color.subText)
                            .font(.bold20)
                    }
                    .padding(.bottom, 20)
                    .underlineTextField()
                    .onTapGesture(perform: {
                        allRanksDataModel.groupId = groupDetailInfoDataModel.groupSearchItem.groupDto.id
                        self.groupDetailInfoDataModel.navigationTag = 2
                    })
                    if (!groupDetailInfoDataModel.groupSearchItem.ownedByLoggedinUser && groupDetailInfoDataModel.groupSearchItem.statusInGroup == 3) {
                        HStack {
                            Text("評価をする")
                                .font(.regular12)
                                .foregroundColor(.mainText)
                            Spacer()
                            if (groupDetailInfoDataModel.reviewDto == nil) {
                                Text("記入していません")
                                    .font(.regular12)
                                    .foregroundColor(Color(hex: "e0e0e0"))
                            } else {
                                RankLabel(rank: groupDetailInfoDataModel.reviewDto!.score)
                            }
                            Spacer()
                            NavigationLink(
                                destination: RankForm().onDisappear(perform: {
                                    groupDetailInfoDataModel.getGroupSearchDto(dialogsDataModel: dialogsDataModel, mainViewDataModel: mainViewDataModel)
                                }), tag: 1, selection: $groupDetailInfoDataModel.navigationTag) {
                                EmptyView()
                            }.isDetailLink(false)
                            NavigationLink(destination: EmptyView()) {
                                EmptyView()
                            }
                            CommonButton(text: groupDetailInfoDataModel.reviewDto == nil ? "記入" : "変更", onClick: {
                                if (groupDetailInfoDataModel.reviewDto != nil) {
                                    rankFormDataModel.comment = groupDetailInfoDataModel.reviewDto!.content
                                    rankFormDataModel.selectedRank = groupDetailInfoDataModel.reviewDto!.score
                                } else {
                                    rankFormDataModel.comment = ""
                                    rankFormDataModel.selectedRank = nil
                                }
                                rankFormDataModel.groupName = groupDetailInfoDataModel.groupSearchItem.groupDto.groupName
                                rankFormDataModel.groupId = groupDetailInfoDataModel.groupSearchItem.groupDto.id
                                
                                self.groupDetailInfoDataModel.navigationTag = 1
                            })
                        }
                        .padding(.bottom, 20)
                        .underlineTextField()
                    }
                }
                .padding(.bottom, 160)
            }
            .padding(.horizontal, 20)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
    }
}
