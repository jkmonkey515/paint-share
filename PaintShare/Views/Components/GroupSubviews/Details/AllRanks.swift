//
//  AllRanks.swift
//  PaintShare
//
//  Created by Limeng Ruan on 4/23/21.
//

import SwiftUI

struct AllRanks: View {
    
    @EnvironmentObject var allRanksDataModel: AllRanksDataModel
    
    @EnvironmentObject var dialogsDataModel: DialogsDataModel
    
    @EnvironmentObject var groupDetailInfoDataModel: GroupDetailInfoDataModel
    
    var body: some View {
        VStack {
            CommonHeader(title: "評価", showBackButton: true, onBackClick: {
                groupDetailInfoDataModel.navigationTag = nil
            })
            HStack {
                RankTab(rankType: -1, count: allRanksDataModel.totalCount, selectedType: $allRanksDataModel.selectedRankType)
                RankTab(rankType: 0, count: allRanksDataModel.rank0Count, selectedType: $allRanksDataModel.selectedRankType)
                RankTab(rankType: 1, count: allRanksDataModel.rank1Count, selectedType: $allRanksDataModel.selectedRankType)
                RankTab(rankType: 2, count: allRanksDataModel.rank2Count, selectedType: $allRanksDataModel.selectedRankType)
            }
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color(hex: "f0f0f0"))
                    .padding(.bottom, 2),
                alignment: .bottom)
            RefreshableScrollView(onRefresh: { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    allRanksDataModel.page = 0
                    allRanksDataModel.loadReviews(dialogsDataModel: dialogsDataModel)
                    done()
                }
            }) {
                VStack {
                    ForEach(allRanksDataModel.commentListItems) {
                        item in
                        RankItem(commentListItem: item)
                            .underlineListItem()
                            .onAppear {
                                allRanksDataModel.loadMoreIfNeeded(currentItem: item, dialogsDataModel: dialogsDataModel)
                            }
                    }
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            debugPrintLog(message:"inventory appear")
            if dialogsDataModel.loginNavigationTag == nil {
                return
            }
            allRanksDataModel.initData(dialogsDataModel: dialogsDataModel)
            allRanksDataModel.page = 0
            allRanksDataModel.loadReviews(dialogsDataModel: dialogsDataModel)
        })
    }
}
